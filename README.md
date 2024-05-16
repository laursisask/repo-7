# Model Download

## Description

This package provides a simple way to download pre-trained models from the internet.

## Installation

To install the package, you can use pip:

```bash
pip install model-download-package
```

## Usage

It needed to provide a yaml file with the models to download and the path to save them. 
The package will download the models in parallel using the number of workers specified.

If the model must be download from GCS it is needed to provide a key file.

```python
from model_download_package import ModelDownload

download = ModelDownload(
    config_file="models_config.yaml",
    max_workers=2,
    model_path="path/to/save/models",
    key_file="path/to/key/file",
)
download.start()
```

## models.yaml
    
The models.yaml file should be in the root of the project and should have the following structure:

```yaml
models:
  checkpoints:
    - name: JuggernautXL.safetensors
      url: gs://fc-freepik-pro-rev1-europe-west1-inference-models/JuggernautXL.safetensors
    - name: epicphotogasm_lastUnicorn.safetensors
      url: gs://fc-freepik-pro-rev1-europe-west1-inference-models/epicphotogasm_lastUnicorn.safetensors
      #force_download: true
    - name: AnimateLCM_sd15_t2v_lora.safetensors
      url: gs://fc-freepik-pro-rev1-europe-west1-inference-models/AnimateLCM_sd15_t2v_lora.safetensors
    - name: add-detail-xl.safetensors
      url: gs://fc-freepik-pro-rev1-europe-west1-inference-models/add-detail-xl.safetensors
      #force_download: true
  ipadapter:
    - name: ip-adapter-plus_sd15.safetensors
      url: gs://fc-freepik-pro-rev1-europe-west1-inference-models/ip-adapter-plus_sd15.safetensors

  animatediff_models:
    - name: AnimateLCM_sd15_t2v.ckpt
      url: gs://fc-freepik-pro-rev1-europe-west1-inference-models/AnimateLCM_sd15_t2v.ckpt

  clip_vision:
    - name: CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors
      url: gs://fc-freepik-pro-rev1-europe-west1-inference-models/CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors

  controlnet:
    - name: control_v1p_sd15_qrcode_monster.safetensors
      url: gs://fc-freepik-pro-rev1-europe-west1-inference-models/control_v1p_sd15_qrcode_monster.safetensors

  upscale_models:
    - name: 8x_NMKD-Superscale_150000_G.pth
      url: gs://fc-freepik-pro-rev1-europe-west1-inference-models/8x_NMKD-Superscale_150000_G.pth
```

If the model is already downloaded and you want to force the download, you can use the `force_download` key.

The models can be downloaded from GCS or from the internet via HTTP.

## License

```text
MIT License

Copyright (c) 2024 Freepik Company, Ltd.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```