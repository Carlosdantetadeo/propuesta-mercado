import fitz
from PIL import Image
from io import BytesIO
from pathlib import Path
import shutil
source = Path('promarsa/CORRECION 6.pdf')
doc = fitz.open(source)
page = doc[0]
parts = sorted(page.get_images(), key=lambda item: page.get_image_rects(item[0])[0].y0)
images = [Image.open(BytesIO(doc.extract_image(item[0])['image'])) for item in parts]
canvas = Image.new('RGB', (images[0].width, sum(im.height for im in images)), 'white')
y = 0
for im in images:
    canvas.paste(im, (0,y))
    y += im.height
canvas.resize((4773, 1967), Image.Resampling.LANCZOS).save(
    'public/promarsa/plano-original.webp', format='WEBP', quality=86, method=6
)
shutil.copyfile(source, 'public/promarsa/plano-original.pdf')
print(canvas.size)
