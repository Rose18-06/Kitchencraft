export function toCurrency(amount: any) {
    return new Intl.NumberFormat('en-IN', { style: 'currency', currency: 'PHP' }).format(amount);
}