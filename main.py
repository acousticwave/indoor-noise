import time
import torchaudio
from glob import glob

files = glob("./indoor-noise-set/CS-APT/audio/*.m4a")

# torchaudio.load("indoor-noise-dataset/CS-APT/audio/*.m4a")
# 순차 처리
start = time.time()
for f in files:
    torchaudio.load(f)
    print(f)
print("순차 처리 시간:", time.time() - start)