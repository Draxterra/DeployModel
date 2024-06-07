from io import BytesIO

import numpy as np
import tensorflow as tf
from PIL import Image


# Read Image:
def read_image(file: bytes) -> Image.Image:
    pil_image = Image.open(BytesIO(file))
    return pil_image



# Load cataract detection model
model_cataract = tf.keras.models.load_model('my_model.h5')

# Cataract model async function
async def predict_cataract(image: Image.Image):
    # Image resizing and formating
    image_array = np.array(image.resize((224, 224))) / 255.0
    image_array = np.expand_dims(image_array, axis=0)
    
    # Assign perdiction cataract model to predict image
    prediction = model_cataract.predict(image_array)
    
    # Get prediction score result
    result = prediction[0][0]

    if result > 0.5:
        pred_info = "Non-cataract"
    else:
        pred_info = "Cataract"
    
    data = {
        "prediction": pred_info,
        "confidence": float(1-result)
    }

    return data

# print('\nCataract Model:\n')
# model_cataract.summary()