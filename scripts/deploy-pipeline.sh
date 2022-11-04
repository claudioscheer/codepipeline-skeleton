script_dir=$(dirname "$0")
packaged_template_path=$script_dir/packaged.yaml

source $script_dir/../.env


aws cloudformation package \
  --template-file $script_dir/../iac/pipeline.yaml \
  --s3-bucket codepipeline-skeleton-47tjp \
  --output-template-file $packaged_template_path \
  --region us-east-1

aws cloudformation deploy \
  --capabilities CAPABILITY_IAM \
  --template-file $packaged_template_path \
  --stack-name codepipeline-skeleton-47tjp \
  --parameter-overrides GitHubSourceConnection=$CONNECTION_ARN \
  --region us-east-1

rm -rf $packaged_template_path
