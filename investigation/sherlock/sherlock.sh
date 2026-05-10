# One-off searches
docker run --rm -t sherlock/sherlock your-username

# If you need to save the output file... (modify as needed)
# Output file will land in ${pwd}/results
#docker run --rm -t -v "$PWD/results:/opt/sherlock/results" sherlock/sherlock -o /opt/sherlock/results/text.txt user123