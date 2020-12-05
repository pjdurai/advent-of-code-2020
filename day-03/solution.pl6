use Test;

# Day 3, Problem 1

# Walk down the array as instructed 'on down 3 to the right'
# and get the list of coordinates.

sub get-coordinates(@map, $down-steps, $right-steps){
    my $num-rows = @map.elems;
    my $num-cols = @map[0].elems;

    gather {
        for zip [0, * + $down-steps ...^ * >= $num-rows], [0, * + $right-steps ... Inf ]  -> ($i, $j) {
            take [$i, $j % $num-cols];
        }
    }
}

sub count-trees(@input, $down-steps, $right-steps){
    my @coords = get-coordinates(@input, $down-steps , $right-steps);
    reduce sub ($acc, @coord){
        my $c = @input[@coord[0]][@coord[1]];
        $c eq "#" ?? $acc + 1 !! $acc;
    }, 0, |@coords;
}

sub solve(@input) {
    count-trees(@input, 1, 3);
}

multi sub MAIN("part1", "test"){
    my $num-trees = solve("input-test".IO.lines().map: {.comb});
    ok $num-trees == 7, " => 7";
}

multi sub MAIN("part1") {
    say solve("input".IO.lines().map: {.comb});
}


# Day 3, Problem 2

sub solve2(@input){
    [*] [(1,1), (1,3), (1,5), (1,7), (2,1)].map(-> @steps {
                                                       my $trees = count-trees(@input, @steps[0], @steps[1]);
                                                       $trees;
                                               })
}
multi sub MAIN("part2", "test"){
    ok solve2("input-test".IO.lines().map: {.comb}) == 336, " == 336";
}

multi sub MAIN("part2") {
    say solve2("input".IO.lines().map: {.comb});
}
