import re
import jsonlines
import gzip

relations = [
    ('is_a', re.compile(r'is (it|the object) an? (?P<value>\w+)\?', flags=re.IGNORECASE)),
    ('is_the', re.compile(r'is (it|the object) the (?P<value>\w+)\?', flags=re.IGNORECASE)),
    ('in_a', re.compile(r'is (it|the object) in an? (?P<value>\w+)\?', flags=re.IGNORECASE)),
    ('in_the', re.compile(r'is (it|the object) in the (?P<value>\w+)\?', flags=re.IGNORECASE)),
    ('on_a', re.compile(r'is (it|the object) on an? (?P<value>\w+)\?', flags=re.IGNORECASE)),
    ('on_the', re.compile(r'is (it|the object) on the (?P<value>\w+)\?', flags=re.IGNORECASE)),
    # XXX: may match proper names ("is it Nadal?"):
    ('attr', re.compile(r'is (it|the object) (?P<value>\w+)\?', flags=re.IGNORECASE)),
]

def get_raw_dataset(fname):
    return jsonlines.Reader(gzip.open(fname))

def parse(q):
    for rel, regex in relations:
        match = regex.match(q['question'])
        if match:
            if q['answer'] == 'No':
                rel = 'NOT_' + rel
            return (rel, match.group('value'))
    return None


if __name__ == "__main__":

    datasets = [
        'data/guesswhat.train.jsonl.gz',
        'data/guesswhat.valid.jsonl.gz',
        'data/guesswhat.test.jsonl.gz',
    ]

    for ds in datasets:
        games = get_raw_dataset(ds)

        histories = []
        for game in games:
            history = []
            for i, q in enumerate(game['qas']):
                rel = parse(q)
                if rel:
                    history.append((i,) + rel)

            histories.append(history)

        output_fn = ds[:-9] + '.history.jsonl'
        with jsonlines.open(output_fn, 'w') as f:
            f.write_all(histories)
