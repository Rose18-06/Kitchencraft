export function toCurrency(amount: number) {
    return new Intl.NumberFormat('en-IN', { style: 'currency', currency: 'PHP' }).format(amount);
}