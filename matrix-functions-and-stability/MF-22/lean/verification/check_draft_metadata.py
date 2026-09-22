from pathlib import Path
import json,yaml,jsonschema
x=yaml.safe_load(Path('formalization.yaml').read_text())
schema=json.loads(Path('../../../docs/lean/schema/v0.4.schema.json').read_text())
jsonschema.validate(x,schema)
c=json.loads(Path('comparator.json').read_text())
assert [a['declaration'] for a in x['status']['main_results']]==c['theorem_names']
assert len(c['theorem_names'])==4 and c['definition_names']==[]
assert x['status']['sorry_count']==4 and all(a['sorry_count']==1 for a in x['status']['main_results'])
assert set(c['permitted_axioms'])=={'propext','Classical.choice','Quot.sound'}
print('Official formalization.yaml v0.4 draft schema and four-export coverage PASS; four deliberate Challenge placeholders, no proof completion claim.')
