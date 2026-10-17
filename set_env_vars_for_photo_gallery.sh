export PROJECT_ID="a-photo-gallery-507623"
export GITHUB_REPO="ChihoSharp/photo-collection" 
export SA_NAME="github-actions-sa"
# Automatically fetches your numeric project ID
export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format="value(projectNumber)")
gcloud config set project $PROJECT_ID