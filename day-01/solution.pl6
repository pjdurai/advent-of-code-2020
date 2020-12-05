use Test;

# https://adventofcode.com/2020/day/1


sub solve(@input, $num-elements) {
    [*] (@input.combinations($num-elements).grep: {([+] $_) == 2020}).flat
}

multi sub MAIN("part1", "test"){
    my @input = 1721, 979, 366, 299, 675, 1456;
    ok solve(@input, 2) == 514579, " => 514579";
}

multi sub MAIN("part1") {
    say solve("input".IO.lines(),2);
}

multi sub MAIN("part2", "test"){
    my @input = 1721, 979, 366, 299, 675, 1456;
    ok solve(@input, 3) == 241861950, " => 241861950";
}

multi sub MAIN("part2") {
    say solve("input".IO.lines(), 3);
}
