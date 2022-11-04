script_dir=$(dirname "$0")
packaged_template_path=$script_dir/packaged.yaml

source $script_dir/../.env

if [ -z ${1} ]
then
  echo "Pass your CloudFormation template file"
  echo "./deploy.sh <template.yaml> <stack name>"
	exit 1
fi

if [ -z ${2} ]
then
  echo "Inform your stack name"
  echo "./deploy.sh <template.yaml> <stack name>"
	exit 1
fi

aws cloudformation package \
  --template-file $script_dir/../iac/${1} \
  --s3-bucket codepipeline-skeleton-47tjp \
  --output-template-file $packaged_template_path \
  --region us-east-1

aws cloudformation deploy \
  --capabilities CAPABILITY_IAM \
  --template-file $packaged_template_path \
  --stack-name codepipeline-skeleton-47tjp \
  --parameters-overrides
  --region us-east-1

rm -rf $packaged_template_path
