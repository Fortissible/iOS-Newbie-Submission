import requests
from bs4 import BeautifulSoup
from PIL import Image
from io import BytesIO
import os

# Create a directory to save images
output_dir = "images"
os.makedirs(output_dir, exist_ok=True)

# Send a GET request to the website
url = 'https://www.tokopedia.com/kyouhobbyshop/product?perpage=20&q=hatsune%20miku%20figure'
response = requests.get(url)

# Check if the request was successful
if response.status_code == 200:
    # Parse the HTML content
    soup = BeautifulSoup(response.text, 'html.parser')

    # Find the div with the specific class
    target_div = soup.find('div', class_='css-8atqhb').find('div')
    target_all_article = soup.findAll('div')
    print(target_all_article)
    for index, article in enumerate(target_all_article):
        if article:
            # Find the image tag within the div
            img_tag = article.find('img')
            if img_tag and 'data-src' in img_tag.attrs:
                img_src = img_tag['data-src']
                print(f'Image source URL: {img_src}')

                # Download the image
                img_response = requests.get(img_src)
                if img_response.status_code == 200:
                    img = Image.open(BytesIO(img_response.content)).convert("RGBA")  # Convert WEBP to PNG

                    # Save @1x, @2x, and @3x versions
                    base_filename = f"image_{index}"
                    sizes = {"@1x": 1, "@2x": 2, "@3x": 3}

                    for suffix, scale in sizes.items():
                        new_size = (img.width * scale, img.height * scale)
                        resized_img = img.resize(new_size, Image.ANTIALIAS)
                        resized_img.save(os.path.join(output_dir, f"{base_filename}{suffix}.png"), format="PNG")

                    print(f"Downloaded and saved {base_filename}@1x, @2x, @3x")
                else:
                    print(f"Failed to download image: {img_src}")
            else:
                print('No image tag found within the target div.')
        else:
            print('Target div not found.')
else:
    print(f'Failed to retrieve the page. Status code: {response.status_code}')
