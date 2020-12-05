use Test;

# Day 4, Problem 1

my @all-fields = ("hgt", "eyr", "ecl", "byr", "iyr", "hcl", "cid", "pid");
my @all-eyecolors = <amb blu brn gry grn hzl oth>;

sub load-input($input-file){
    # cleanup the input and parse it into an array of hashes representing passport data
    ($input-file.IO.slurp
     ==> split(/\n\n/)
     ==> map({.split(/\n/).join(" ")})
     ==> map({.words})
     ==> map(-> @record {
                    reduce sub (%acc, $name-value){
                        my @kv = $name-value.split(/\:/);
                        %acc{@kv[0]} = @kv[1];
                        %acc;
                    }, {}, |@record;
                });
    );
}

# Check if the passport hash has all the fields. (cid optional)
sub check-for-fields(%passport){
    my @keys = %passport.keys;
    my @diff = @(@all-fields (-) @keys);
    @diff.elems == 0 || (@diff.elems == 1 && @diff[0].key.Str eq "cid")
}

sub solve($input-file) {
    my @passports = load-input($input-file);
    # Count vlid passports
    reduce sub ($count, %pp){
        check-for-fields(%pp) ?? $count+1 !! $count;
    }, 0, |@passports;
}

multi sub MAIN("part1", "test"){
    ok solve("input-test") == 2, " => 2";
}

multi sub MAIN("part1") {
    say solve("input");
}

# Day 4, Problem 2

sub check-height($hgt){
    my $result = do if $hgt ~~ /^$<height> = (\d+) $<unit> = (in || cm)$/ {
        so ((~$<unit> eq "cm" && 150 <= ~$<height>.Numeric <= 193) ||
        (~$<unit> eq "in" && 59 <= ~$<height>.Numeric <= 76));
    } else{
        False;
    }
    $result;
}

sub check-hair-color($hcl){
    so $hcl ~~ /^\# <xdigit> ** 6/;
}

sub check-eye-color($ecl) {
    $ecl ∈ @all-eyecolors;
}

sub check-for-values(%passport){
    %passport<byr>.chars == 4 && 1920 <= %passport<byr>.Numeric <= 2002 &&
    %passport<iyr>.chars == 4 && 2010 <= %passport<iyr>.Numeric <= 2020 &&
    %passport<eyr>.chars == 4 && 2020 <= %passport<eyr>.Numeric <= 2030 &&
    %passport<pid> ~~ /^\d ** 9 $/ &&
    check-hair-color(%passport<hcl>) &&
    check-eye-color(%passport<ecl>) &&
    check-height (%passport<hgt>);
}

sub solve2($input-file){
    my @passports = load-input($input-file);
    # Count vlid passports
    reduce sub ($count, %pp){
        (check-for-fields(%pp) && check-for-values(%pp)) ?? $count+1 !! $count;
    }, 0, |@passports;
}
multi sub MAIN("part2", "test"){
    ok solve2("valid-passports") == 4, " => 4";
    ok solve2("invalid-passports") == 0, " => 0";
}

multi sub MAIN("part2") {
   say solve2("input");
}
