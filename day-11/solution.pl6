use Test;

# Problem 1

multi sub find-adj-seat-coords(@layout, @coord){
    my $i = @coord[0];
    my $j = @coord[1];
    my @adj = (($i-1, $j-1), ($i-1, $j), ($i-1, $j+1),
               ($i, $j-1), ($i, $j+1),
               ($i+1, $j-1), ($i+1, $j), ($i+1, $j+1));
    @adj.grep: {$_[0] >= 0 && $_[1] >= 0 &&  $_[0] < @layout.elems && $_[1] < @layout[0].elems};
}

# make a static hash of all the neighboring coordinates for
# each coordinate in the layout. We don't want to be calculating
# this every time.

multi sub find-adj-seat-coords(@layout){
    reduce sub (%acc, @coord) {
        my @adj = find-adj-seat-coords(@layout, @coord);
        %acc{@coord.Str} = @adj;
        %acc;
    }, {}, | ((0..^@layout.elems) X (0..^@layout[0].elems))
}
sub print-layout(@layout){
    for @layout -> @row {
        say @row.join(" ");
    }
    say "";
}

sub get-num-occupied-adj-seats(%adj-map, @layout, @coord){
    %adj-map{@coord.Str}.map({@layout[$_[0]][$_[1]]}).grep(/\#/).elems
}

sub is-seat-empty(@layout, @coord){
    @layout[@coord[0]][@coord[1]] eq "L";
}

sub is-seat-occupied(@layout, @coord){
    @layout[@coord[0]][@coord[1]] eq "#";
}

sub is-seat-floor(@layout, @coord){
    @layout[@coord[0]][@coord[1]] eq ".";
}

sub get-tobe-occupied(%adj-map, @layout){
    my $num-rows = @layout.elems;
    my $num-cols = @layout[0].elems;
    reduce sub (@acc, @coord){
            if is-seat-empty(@layout, @coord) && get-num-occupied-adj-seats(%adj-map, @layout, @coord) == 0 {
                @acc.push(@coord);
            }
            @acc;
        }, [], | ((0..^$num-rows) X (0..^$num-cols));
}

sub get-tobe-emptied(%adj-map, @layout){
    my $num-rows = @layout.elems;
    my $num-cols = @layout[0].elems;
    reduce sub (@acc, @coord){
            if is-seat-occupied(@layout, @coord) && get-num-occupied-adj-seats(%adj-map, @layout, @coord) >= 4 {
                @acc.push(@coord);
            }
            @acc;
        }, [], | ((0..^$num-rows) X (0..^$num-cols));
}

sub update-layout(@layout, @coords, $new-state){
    return @layout if @coords.elems == 0;

    reduce sub (@acc, $coord){
        @acc[$coord[0]][$coord[1]] = $new-state;
        @acc;
    }, @layout, |@coords;
}

sub load-input(@input){
    @input.map(-> $line {
                      Array.new($line.comb());
                  });
}

sub solve(@input){
    my @layout = load-input(@input);
    my $num-rows = @layout.elems;
    my $num-cols = @layout[0].elems;

    my %adj-map = find-adj-seat-coords(@layout);

    my $changes-detected;

    my $result = gather loop {
        print-layout(@layout);
        my @tobe-occupied = get-tobe-occupied(%adj-map, @layout);
        my @tobe-emptied = get-tobe-emptied(%adj-map, @layout);
        if @tobe-occupied.elems == 0 && @tobe-emptied.elems == 0 {
            # return number of occupied seats.
            take (reduce sub (@acc, $item) {
                         @acc.append: $item.flat;
                         @acc;
                     }, [], |@layout).grep(/"#"/).elems;
            last;
        } else {
            @layout = update-layout(@layout, @tobe-occupied, "#");
            print-layout(@layout);
            @layout = update-layout(@layout, @tobe-emptied, "L");
        }
    };
    $result[0];
}

multi sub MAIN("part1", "test"){
    ok solve("input-test".IO.lines()) == 37, " => 37";
}

multi sub MAIN("part1") {
    say solve("input".IO.lines());
}

# Problem 2

sub solve2(@input){
}

multi sub MAIN("part2", "test"){
    #ok solve2("input-test".IO.lines()) == 1, " => 1";
}

multi sub MAIN("part2") {
   # say solve2("input".IO.lines());
}
