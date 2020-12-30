use Test;

# Day 3, Problem 1

sub solve(@input) {
    my $counter = 0;
    my $acc = 0;
    my @visited = [];

    loop {
        if so @visited[$counter] {
            last;
        }
        @visited[$counter] = 1;
        given @input[$counter] {
            when /^nop/ {
                $counter++;
            }
            when /^acc\s+(.)(\d+)/ {
                my $n = $0 eq '-' ?? -$1 !! $1;
                $acc += $n;
                $counter++;
            }
            when /^jmp\s+(.)(\d+)/ {
                my $n = $0 eq '-' ?? -$1 !! $1;
                $counter = $counter + $n;
            }
        }
        say "Counter = $counter   Acc = $acc";
    }
    $acc;
}

multi sub MAIN("part1", "test"){
    ok solve("input-test".IO.lines()) == 5, " => 5";
}

multi sub MAIN("part1") {
    say solve("input".IO.lines());
}

# Day 3, Problem 2

sub does-terminate(@input){

}
sub solve(@input) {
    my $counter = 0;
    my $acc = 0;
    my @visited = [];

    loop {
        if so @visited[$counter] {
            last;
        }
        @visited[$counter] = 1;
        given @input[$counter] {
            when /^nop/ {
                $counter++;
            }
            when /^acc\s+(.)(\d+)/ {
                my $n = $0 eq '-' ?? -$1 !! $1;
                $acc += $n;
                $counter++;
            }
            when /^jmp\s+(.)(\d+)/ {
                my $n = $0 eq '-' ?? -$1 !! $1;
                $counter = $counter + $n;
            }
        }
        say "Counter = $counter   Acc = $acc";
    }
    $acc;
}
sub solve2(@input){
}
multi sub MAIN("part2", "test"){
    #ok solve2("input-test".IO.lines()) == 1, " => 1";
}

multi sub MAIN("part2") {
   # say solve2("input".IO.lines());
}
