use Test;

# https://adventofcode.com/2020/day/2

# Day 2, Problem 1

# Breakup '1-3 a: abcde' in to components

sub parse-input-line($line){
    my ($min, $max, $letter, $password) = @($line ~~ m/(\d+)\-(\d+)\s+(\w)\:\s+(\w+)/);
    ($min.Int, $max.Int, $letter.Str, $password.Str);
}

sub solve(@input) {
    reduce sub ($acc, $line){
        my ($min, $max, $letter, $password) = parse-input-line($line);
        my $num-matches = $password.match($letter, :g).elems;
        $min <= $num-matches <= $max ?? $acc + 1 !! $acc;
    }, 0, |@input;
}

multi sub MAIN("part1", "test"){
    ok solve("input-test".IO.lines()) == 2, " => 2";
}

multi sub MAIN("part1") {
    say solve("input".IO.lines());
}

# Day 2, Problem 2

sub solve2(@input){
    reduce sub ($acc, $line){
        my ($pos1, $pos2, $letter, $password) = parse-input-line($line);
        my @pos-vals = $password.comb[[$pos1-1, $pos2-1]];
        @pos-vals.grep($letter) == 1 ?? $acc + 1 !! $acc;
    }, 0, |@input;

}
multi sub MAIN("part2", "test"){
    ok solve2("input-test".IO.lines()) == 1, " => 1";
}

multi sub MAIN("part2") {
    say solve2("input".IO.lines());
}
