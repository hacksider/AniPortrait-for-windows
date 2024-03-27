Set-Location $PSScriptRoot

$Env:PIP_DISABLE_PIP_VERSION_CHECK = 1
$Env:PIP_INDEX_URL = "https://mirror.baidu.com/pypi/simple"
$Env:HF_ENDPOINT = "https://hf-mirror.com"

if (!(Test-Path -Path "venv")) {
    Write-Output  "����python���⻷��venv..."
    python -m venv venv
}
.\venv\Scripts\activate

Write-Output "��װ����..."
pip install -U -r requirements-windows.txt

Write-Output "���ģ��..."
if (!(Test-Path -Path "pretrained_model")) {
    Write-Output  "����AniPortraitģ��..."
    huggingface-cli download --resume-download ZJYang/AniPortrait --local-dir pretrained_model
}

Set-Location .\pretrained_model

if (!(Test-Path -Path "image_encoder")) {
    Write-Output  "����image_encoderģ��..."
    huggingface-cli download --resume-download bdsqlsz/image_encoder --local-dir image_encoder
}

if (!(Test-Path -Path "wav2vec2-base-960h")) {
    Write-Output  "����wav2vec2ģ��..."
    huggingface-cli download --resume-download facebook/wav2vec2-base-960h --local-dir wav2vec2-base-960h
}

$install_SD15 = Read-Host "�Ƿ���Ҫ����huggingface��SD15ģ��? ��������û���κ�SD15ģ��ѡ��y�������Ҫ������SD1.5ģ��ѡ�� n��[y/n] (Ĭ��Ϊ y)"
if ($install_SD15 -eq "y" -or $install_SD15 -eq "Y" -or $install_SD15 -eq "") {
    if (!(Test-Path -Path "stable-diffusion-v1-5")) {
        Write-Output  "���� stable-diffusion-v1-5 ģ��..."
        huggingface-cli download --resume-download bdsqlsz/stable-diffusion-v1-5 --local-dir stable-diffusion-v1-5   
    }
}

Write-Output "��װ���"
Read-Host | Out-Null ;
