use Test;

# Problem 1

sub solve(@input, $preamble-len) {
    for [$preamble-len..^@input.elems] -> $i {
       if @input[$i] ∉ @input[$i-$preamble-len..^$i].combinations(2).map({[+] $_}) {
            return @input[$i];
        }
    }
}

multi sub MAIN("part1", "test"){
    ok solve("input-test".IO.lines().map({.Int}), 5) == 127, " = 127";
    #ok solve("input-test".IO.lines()) == 2, " => 2";
}

multi sub MAIN("part1") {
    say solve("input".IO.lines().map({.Int}), 25);
}

# Problem 2

sub solve2(@input, $preamble-len){
    # use the first solution to find the invalid number
    my $invalid-num = solve("input".IO.lines().map({.Int}), $preamble-len);
    for [0..^@input.elems - 1] -> $i {
            say $i;
        for [$i+1..^@input.elems] -> $j {
            my $sum = 0;
            for [$i..$j] -> $k {
                $sum += @input[$k];
            }
            #if ([+] @input[$i..$j]) == $invalid-num { # this is nicer but too slow.
            if $sum == $invalid-num {
                my @seq = @input[$i..$j].sort;
                return @seq.head + @seq[*-1];
            }
        }
    }
}
multi sub MAIN("part2", "test"){
    ok solve2("input-test".IO.lines().map({.Int}), 5) == 62, " = 62";
}

multi sub MAIN("part2") {
    say solve2("input".IO.lines().map({.Int}), 25);
}
