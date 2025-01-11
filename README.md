# Tomato Disease Detection Using Hybrid Deep Learning Model

![Tomato Disease Detection](https://link-to-your-image.png)

## Overview

This project presents a **mobile application** designed to detect tomato diseases using a hybrid deep learning model. By leveraging the power of Convolutional Neural Networks (CNN) and Vision Transformers (ViT), this application aims to assist farmers in identifying diseases early, thus enabling timely intervention and reducing crop loss.

## Table of Contents

- [Methodology](#methodology)
  - [Dataset](#dataset)
  - [Data Preprocessing](#data-preprocessing)
  - [Model Selection](#model-selection)
  - [Feature Selection](#feature-selection)
  - [Hybrid Model](#hybrid-model)
  - [Mobile App Development](#mobile-app-development)
- [Results](#results)
  - [Hybrid Deep Learning Model](#hybrid-deep-learning-model)
- [Conclusion and Future Work](#conclusion-and-future-work)
- [project setup](#project-setup-and-prerequisite)
- [Contributing](#contributing)
- [License](#license)


## Methodology

### Dataset

The dataset used includes 2,064 images of tomato leaves categorized into early blight, leaf spot, yellow curl, and healthy leaves. The images were sourced from a public dataset and augmented to increase variety.

### Data Preprocessing

Data preprocessing involved resizing images, normalization, and data augmentation techniques such as rotation, zooming, and flipping to enhance the robustness of the model.

### Model Selection

We experimented with several deep learning models, including VGG16, ResNet50, and Vision Transformers (ViT). The final model is a hybrid architecture combining the strengths of CNNs and ViTs.

### Feature Selection

The hybrid model leverages local feature extraction (edges, patterns) using CNNs and global feature extraction (contextual information) using ViTs.

### Hybrid Model

Two hybrid architectures were developed: VGG16 + ViT and ResNet50 + ViT. The final layer of each network was removed, and the outputs were concatenated before passing through a fully connected layer for classification.

### Mobile App Development

The mobile application was developed using Flutter, providing a user-friendly interface for farmers to capture images of tomato leaves and get real-time disease diagnostics and treatment suggestions.

## Results

### Hybrid Deep Learning Model

The hybrid model combining VGG16 and ViT achieved impressive results with high accuracy, precision, and recall. Detailed performance metrics are available in the report.

## Conclusion and Future Work

The project successfully developed a high-precision tomato disease detection application. Future work will focus on expanding the dataset, improving model accuracy, and adding more features to the mobile application.

## Project setup and prerequisite

this project is built with the flutter and backend code is on python. if u can configure ngrok then u don't need the index.php and cors.php on outermost directory and u should replace url on 'cropdetectionsample/lib/localhosturl.dart' Otherwiese you need

flutter
python
Xampp

1. on your c:/xampp/htdocs create/php/diseasedetectiona and clone this repository
2. in cmd type 'ipconfig' and get the 'IPv4 Address' and place it on the "cropdetectionsample/lib/localhosturl.dart"
3. open xampp and start apache server then run your main.py then hit flutter run and make sure the laptop and mobile are on same wifi
   



## Contributing

Contributions are welcome! Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file for details on the code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
