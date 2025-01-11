document.querySelector('form').addEventListener('submit', function(event) {
    event.preventDefault();
    const formData = new FormData(event.target);
    fetch('/predict', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        document.getElementById('prediction').textContent = `Prediction: ${data.prediction}`;
        document.getElementById('confidence').textContent = `Confidence: ${data.confidence}`;

    })
    .catch(error => {
        console.error('Error:', error);
    });
});
