void checkBalance({
  required String name,
  required double balance,
}) => print('User: $name, Available balance: $balance');


double deposit({
  required double currentBalance,
  double? amount,
}) {
  double depositAmount = amount ?? 0.0;

  double updatedBalance = currentBalance + depositAmount;

  print('Deposit: $depositAmount');
  print('New balance: $updatedBalance');

  return updatedBalance;
}


double withdraw({
  required String name,
  required double currentBalance,
  double? amount,
  int? pinCode,
}) {
  int enteredPin = pinCode ?? 0000;

  if (enteredPin != 1234) {
    print('Error! Incorrect PIN');
    return currentBalance;
  }

  double withdrawAmount = amount ?? 0.0;

  if (withdrawAmount > currentBalance) {
    print('Error! Insufficient funds');
    return currentBalance;
  }

  double updatedBalance = currentBalance - withdrawAmount;

  print('Withdrawal successful.');
  print('Withdrawn: $withdrawAmount');
  print('New balance: $updatedBalance');

  return updatedBalance;
}


void main() {
  double balance = 10000.0;

  checkBalance(
    name: 'D',
    balance: balance,
  );

  balance = deposit(
    currentBalance: balance,
    amount: 5000.0,
  );

  balance = withdraw(
    name: 'D',
    currentBalance: balance,
    amount: 3000.0,
    pinCode: 1234,
  );

  checkBalance(
    name: 'D',
    balance: balance,
  );
}
