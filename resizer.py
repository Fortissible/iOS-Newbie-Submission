import os
from PIL import Image

# Define the folder containing JPG images
folder_path = "./images"  # Change this to your folder path

# Create an output folder
output_folder = os.path.join(folder_path, "resized")
os.makedirs(output_folder, exist_ok=True)

# Loop through all JPG files in the folder
for filename in os.listdir(folder_path):
    if filename.lower().endswith(".jpg"):
        img_path = os.path.join(folder_path, filename)
        img = Image.open(img_path)

        # Get the base name without extension
        base_name = os.path.splitext(filename)[0]

        # Save original size as x1
        img.save(os.path.join(output_folder, f"{base_name}.jpg"), quality=95)

        # Resize for @2x
        img_2x = img.resize((img.width * 2, img.height * 2), Image.LANCZOS)
        img_2x.save(os.path.join(output_folder, f"{base_name}@2x.jpg"), quality=95)

        # Resize for @3x
        img_3x = img.resize((img.width * 3, img.height * 3), Image.LANCZOS)
        img_3x.save(os.path.join(output_folder, f"{base_name}@3x.jpg"), quality=95)

        print(f"Resized {filename} → @1x, @2x, @3x saved.")

print("✅ Image resizing completed!")
