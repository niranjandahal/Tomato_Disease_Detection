from flask import Flask, request, jsonify, render_template
import torch
from PIL import Image
import numpy as np
from hybrid_model import HybridModel
from torchvision import transforms
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

def preprocess_image(image):
    preprocess = transforms.Compose([
        transforms.Resize((224, 224)),
        transforms.ToTensor(),
        transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
    ])
    image = preprocess(image)
    # Add batch dimension
    image = image.unsqueeze(0)
    return image


def load_model(model_path):
    model = torch.load(model_path, map_location=torch.device('cpu'))
    model.eval()  # Set the model to evaluation mode
    return model


def predictoutput(model, image):
    with torch.no_grad():
        output = model(image)
        probabilities = torch.nn.functional.softmax(output[0], dim=0)
        predicted_class_index = torch.argmax(probabilities).item()
        return predicted_class_index, probabilities[predicted_class_index].item()

class_names = ['Tomato___Bacterial_spot', 'Tomato___Early_blight', 'Tomato___healthy', 'Tomato___Late_blight',
               'Tomato___Leaf_Mold', 'Tomato___Septoria_leaf_spot', 'Tomato___Spider_mites Two-spotted_spider_mite',
               'Tomato___Target_Spot', 'Tomato___Tomato_mosaic_virus', 'Tomato___Tomato_Yellow_Leaf_Curl_Virus']


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'}), 400
    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400

    image = Image.open(file.stream)
    # model_path = "https://github.com/teksingh2/final-research/blob/master/model.pth"
    model_path = 'model.pth'
    image = preprocess_image(image)
    model = load_model(model_path)
    predicted_class_index, confidence = predictoutput(model, image)
    print(predicted_class_index)
    return str(predicted_class_index)
    # return jsonify({"index": predicted_class_index, "confidence": confidence})



if __name__ == '__main__':
    app.run(debug=False)
