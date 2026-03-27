/// C(n, r)
fn combinations(n: u128, r: u128) -> u128 {
    if r > n {
        return 0;
    }

    let r = r.min(n - r);
    let mut result = 1u128;

    for i in 0..r {
        result = result * (n - i) / (i + 1);
    }

    result
}
