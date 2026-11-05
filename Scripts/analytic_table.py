import pandas as pd

lab3_data = pd.read_csv(snakemake.input["lab3_data"])
lab4_data = pd.read_csv(snakemake.input["lab4_data"], sep="\t")

lab3_data["source"] = "Lab3"
lab4_data["source"] = "Lab4"

combined = pd.concat(
    [lab3_data, lab4_data],
    ignore_index=True,
    sort=False
)

combined.to_csv(
    snakemake.output[0],
    index=False,
    na_rep="NA"
)