DBT Jaffleshop Xebia BigQuery


## DBT Docs

Checkout the [docs](https://lassebenni.github.io/dbt-jaffleshop/#!/overview).

## Steps to develop

1. Create a python virtualenv (at least 3.8): `python3.8 -m venv .venv`. Using conda or another virtual environment is fine too, but will not be assumed here.
2. Activate the virtualenv: `source .venv/bin/activate` in Linux/Mac or on Windows `.\venv\Scripts\activate`.
3. Now using the venv, install the python requirements: `pip install -r requirements.txt` this will install dbt.
4. Now, if using `gcloud` authentication you should be fine. Using a credentials key file, you need to provide the path to this file in `profiles.yml`: 
```
      method: service-account
      keyfile: .creds/credentials.json
```

The `.creds` folder is in `gitignore` and should never be commited to Git!

5. Run `dbt debug` to check the connection to BigQuery.
6. Now we need to install the packages for dbt, run `dbt deps`.
7. You are ready to go!


## Using DBT Coves for source generation
You can use the `dbt-coves` Python package to interactively choose and generate staging models and source files from the command line. The `.dbt_coves` folder contains custom templating to help generate the files.

Generate sources
1. Run `dbt-coves generate sources`.
2. Choose the source tables from BigQuery you want to create staging models for.
3. The files should be automatically generated in the `models/staging/<source_name>` folder along with a source YAML file.

Generate model properties
We can also create a properties YAML for an existing model so you don't need to do that manually.
1. Run `dbt-coves generate properties`.
2. Choose the models from your schema in BigQuery.
3. The properties YAML should be automatically generated in the same folder as the model.

