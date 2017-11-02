# Hellokite CI Documentation

## Login to concourse
```
fly -t ci login -n TEAM_NAME -c CONCOURSE_URL
```

## Create or update the pipeline
```
fly -t ci set-pipeline -p hellokite -c .kite/pipelines/review.yml -n
```

## Un-pause the pipeline
```
fly -t ci unpause-pipeline -p hellokite
```
