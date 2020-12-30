use Test;

# Problem 1

sub is-first-time(@arr){
    (@arr.first: * == @arr[*-1], :k) == @arr.elems-1;
}

sub solve(@array, $max) {
    while @array.elems < $max {
        my $cur-num-elems = @array.elems;

        if is-first-time(@array) {
            #say "First Time";
            @array.push(0);
        } else {
            my $cur-index = @array.elems-1;
            my $prev-index = @array.head(*-1).first: * == @array[*-1], :k, :end;
            #say "Cur-index = ", $cur-index, "   Prev Occurance:", $prev-index;
            @array.push($cur-index - $prev-index);
        }
        say @array.elems if @array.elems %% 1000;
    }
    @array[$max-1];
}

multi sub MAIN("part1", "test"){
    ok solve(Array[Int].new(0,3,6), 2020) == 436, " => 436";
    ok solve(Array[Int].new(1,3,2), 2020) == 1, " => 1";
    ok solve(Array[Int].new(2,1,3), 2020) == 10, " => 10";
    ok solve(Array[Int].new(3,1,2), 2020) == 1836, " => 1836";
}

multi sub MAIN("part1") {
    say solve2(Array[Int].new(5,1,9,18,13,8,0),2020);
}

# Problem 2
# The above solution works fine for 2020. But it bogs down with 30,000,000 as input
# We need a less wasteful solution.

sub solve2(@array, $max){

    # This hash stores the numbers and the last time (index) they had been seen.
    my %last-indexes;

    # Add the initial input list(all but the last one)

    for @array.head(*-1).kv -> $i, $e {
        %last-indexes{$e} = $i;
    }

    # Use the last-item to compute the next item.
    # Then add the last time to the hash
    # Next item becomes last item.

    my $last-item = @array.pop;
    my $next-item;

    for @array.elems..^$max-1 -> $i {
        # already spoken?
        if %last-indexes{$last-item}:!exists {
            $next-item = 0;
        } else {
            $next-item = $i - %last-indexes{$last-item};
        }
        %last-indexes{$last-item} = $i;
        $last-item = $next-item;
        ".".print if $i %% 1000000;
    }
    say "";
    say %last-indexes.elems;
    $last-item;
}

multi sub MAIN("part2", "test"){
    ok solve2(Array[Int].new(5,1,9,18,13,8,0),2020) == 376;
    #ok solve2(Array[Int].new(0,3,6), 30000000) == 175594, " => 175594";
    # ok solve2(Array[Int].new(1,3,2), 2020) == 1, " => 1";
    # ok solve2(Array[Int].new(2,1,3), 2020) == 10, " => 10";
    # ok solve2(Array[Int].new(3,1,2), 2020) == 1836, " => 1836";
}

multi sub MAIN("part2") {
   # say solve2("input".IO.lines());
    say solve2(Array[Int].new(5,1,9,18,13,8,0),30000000);
}
