import cv2
import numpy as np
import matplotlib.pyplot as plt

from tkinter import Tk, filedialog
from PIL import Image

# No show main window
Tk().withdraw()

# open file in choice dialog and read image
## original (opencv format is BGR, need to convert to RGB)
file_path = filedialog.askopenfilename(filetypes=[("Image Files", "*.jpg;*.png;*.bmp")])
im1 = Image.open(file_path).convert("RGB")

# embed (opencv format is BGR, need to convert to RGB)
file_path = filedialog.askopenfilename(filetypes=[("Image Files", "*.jpg;*.png;*.bmp")])
im2 = Image.open(file_path).convert("RGB")

origin_np = np.array(im1).astype(np.float32)
em_np = np.array(im2).astype(np.float32)

# get image information
r1, c1, _ = origin_np.shape

target_h = r1 // 2
target_w = c1 // 2

start_r = (r1 - target_h) // 2
end_r   = start_r + target_h
start_c = (c1 - target_w) // 2
end_c   = start_c + target_w

im2_resized = im2.resize((target_w, target_h), Image.Resampling.LANCZOS)
em_np = np.array(im2_resized).astype(np.float32)

origin_np[start_r:end_r, start_c:end_c, :] = np.clip(
    origin_np[start_r:end_r, start_c:end_c, :] + 0.3 * em_np,
    0, 255
)
result = Image.fromarray(origin_np.astype(np.uint8))

plt.subplot(1, 2, 1)
plt.imshow(im1)
plt.title("Original Image")
plt.axis('off')  

plt.subplot(1, 2, 2)
plt.imshow(origin_np.astype(np.uint8))
plt.title("Embedded Image")
plt.axis('off')  
plt.show()
