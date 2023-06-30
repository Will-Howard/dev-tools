CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
MASTER_BRANCH="origin/master"

# use the first argument as the new branch name if given, otherwise use "${CURRENT_BRANCH}-squash"
if [ "$#" -ne 1 ]; then
  NEW_BRANCH="${CURRENT_BRANCH}-squash"
else
  NEW_BRANCH="$1"
fi

echo "******"
echo "Fetching latest from origin"
echo "******"
git fetch

echo "******"
echo "Creating new branch $NEW_BRANCH based on $MASTER_BRANCH"
echo "******"
git checkout -b "$NEW_BRANCH" "$MASTER_BRANCH" || exit 1

echo "******"
echo "Copying over files from $CURRENT_BRANCH"
echo "******"
git checkout "$CURRENT_BRANCH" $(git diff --name-only "$CURRENT_BRANCH" "$MASTER_BRANCH")
