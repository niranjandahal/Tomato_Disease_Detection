from transformers import ViTModel, ViTConfig
import torch
import torch.nn as nn
from torchvision.models import resnet50


class HybridModel(nn.Module):
    def __init__(self, num_classes):
        super(HybridModel, self).__init__()

        # Load a pre-trained ResNet50 as the CNN part
        self.cnn = resnet50(pretrained=True)
        self.cnn.fc = nn.Identity()  # Remove the last fully connected layer

        # Configure and load a Vision Transformer
        config = ViTConfig(
            image_size=224,  # Assuming input images are 224x224
            patch_size=16,
            num_classes=num_classes,
            hidden_size=768,
            num_hidden_layers=12,
            num_attention_heads=12,
            intermediate_size=3072,
        )
        self.vit = ViTModel(config)

        # Fully connected layer to combine CNN and ViT outputs
        self.fc = nn.Linear(2816, num_classes)  # Adjust the input size to 2816

    def forward(self, x):
        # Pass the input through the CNN
        cnn_out = self.cnn(x)

        # Flatten the CNN output
        cnn_out = cnn_out.view(cnn_out.size(0), -1)

        # Pass the input through the ViT
        vit_out = self.vit(x).last_hidden_state[:, 0, :]  # Take the [CLS] token's output

        # Concatenate the CNN and ViT outputs
        combined = torch.cat((cnn_out, vit_out), dim=1)

        # Pass the combined output through the fully connected layer
        out = self.fc(combined)

        return out
