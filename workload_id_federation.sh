#!/bin/bash
PROJECT_ID="a-photo-gallery-507623" 
SA_NAME="github-actions-sa"
GITHUB_REPO="ChihoSharp/photo-collection" 
PROJECT_NUMBER="343219569614"
echo "Creating OIDC Provider with strict attribute condition..."
gcloud iam workload-identity-pools providers create-oidc github-provider \
--location="global" \
--workload-identity-pool="github-pool" \
--display-name="GitHub Provider" \
--attribute- mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository" \
--attribute-condition="assertion.repository == '$GITHUB_REPO'" \ --issuer-uri="https://token.actions.githubusercontent.com" \ --project=$PROJECT_ID
echo "Binding GitHub repository to Service Account..."
gcloud iam service-accounts add-iam-policy-binding $SA_NAME@$PROJECT_ID.iam.gserviceaccount.com \
--role="roles/iam.workloadIdentityUser" \
-- member="principalSet://iam.googleapis.com/projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/g
ithub-pool/attribute.repository/$GITHUB_REPO"
echo "Done! Your provider string for your GitHub Actions YAML file is:"
echo "projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/github-pool/providers/github-provider"