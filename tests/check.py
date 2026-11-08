"""Run standalone RV32 examples with RARS 1.6. No Python packages required."""
import argparse
import pathlib
import re
import subprocess
import tempfile

ROOT = pathlib.Path(__file__).resolve().parents[1]
EXPECTED = ['111222333', 'pari', '55', '5040', '49', 'Cat\nSnowball',
            "What's your name? Hello, Ada", '6', '20', '-15', '435', '39',
            '1', '5', '5', '2', '7', '4', '7', '19', '15', '5', '1']

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('jar', type=pathlib.Path, help='Path to rars1_6.jar')
    parser.add_argument('--java', default='java', help='Java executable')
    parser.add_argument('--classpath', help=argparse.SUPPRESS)
    parser.add_argument('--preferences-factory', help=argparse.SUPPRESS)
    args = parser.parse_args()
    files = sorted(ROOT.glob('*.asm'))
    assert len(files) == 23, f'Expected 23 programs, found {len(files)}'
    cases = [(p.name, p.read_text(), expected, 'Ada\n' if i == 6 else '')
             for i, (p, expected) in enumerate(zip(files, EXPECTED))]

    def variant(program, name, expected, **words):
        source = files[program - 1].read_text()
        for label, value in words.items():
            source, count = re.subn(r'(?m)(\b' + re.escape(label) + r'\s*:\s*\.word\s*)[^#\n]+',
                                    lambda m: m[1] + str(value) + '  ', source)
            assert count == 1, (program, label, count)
        cases.append((f'{program:02d}-{name}', source, str(expected), ''))

    variant(1, 'second-smaller', -7, first=5, second=-7)
    variant(2, 'negative-odd', 'dispari', number=-3)
    for n, expected in [(0, 0), (-1, 0), (1, 1)]:
        variant(3, f'n-{n}', expected, n=n)
    for n, expected in [(0, 1), (12, 479001600), (-1, -1), (13, -1)]:
        variant(4, f'n-{n}', expected, n=n)
    for index, expected in [(-1, -1), (6, -1), (0, 1)]:
        variant(8, f'index-{index}', expected, index=index)
    for number in (9, 10, 12):
        for count in (0, -1):
            variant(number, f'count-{count}', 0, count=count)
    variant(12, 'single', 12, count=1)
    variant(13, 'equal', 0, x=10)
    variant(13, 'empty', 1, n=0)
    for number, expected in [(14, 2), (15, 2)]:
        variant(number, 'same-targets', expected, x=3, y=3)
        variant(number, 'empty', 0, n=0)
        variant(number, 'negative-count', 0, n=-1)
    variant(16, 'missing', -1, target=100)
    for name, x, y, expected in [('negative', -1, 3, 0), ('reversed', 3, 2, 0),
                                 ('past-end', 0, 7, 0), ('single', 2, 2, 3)]:
        variant(17, name, expected, x=x, y=y)
    for number in (18, 19, 20, 21, 22):
        variant(number, 'empty-list', 0, **{'lista' if number == 18 else 'list': 0})
    variant(22, 'one-node', 0, node0='4,0')
    for value, expected in [(7, 1), (1, 1), (26, 1), (5, 0), (-1, 0), (100, 0)]:
        variant(23, f'target-{value}', expected, N=value)
    variant(23, 'empty-tree', 0, tree=0)

    failures = []
    with tempfile.TemporaryDirectory() as temp:
        for name, source, expected, stdin in cases:
            path = pathlib.Path(temp) / 'case.asm'
            path.write_text(source)
            command = [args.java]
            if args.preferences_factory:
                command += ['-Djava.util.prefs.PreferencesFactory=' + args.preferences_factory]
            command += (['-cp', args.classpath, 'rars.Launch'] if args.classpath
                        else ['-jar', str(args.jar.resolve())])
            command += ['nc', 'me', 'ae1', 'se1', '100000', str(path)]
            try:
                result = subprocess.run(command, input=stdin, text=True, capture_output=True, timeout=15)
                actual = result.stdout.strip()
                if result.returncode or actual != expected or 'maximum' in result.stderr.lower():
                    failures.append(f'{name}: expected {expected!r}, got {actual!r}; {result.stderr}')
            except subprocess.TimeoutExpired:
                failures.append(f'{name}: timed out')
    for failure in failures:
        print('FAIL', failure)
    print(f'{len(cases) - len(failures)}/{len(cases)} checks passed')
    return bool(failures)

if __name__ == '__main__':
    raise SystemExit(main())
