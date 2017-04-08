package cn.itcast.estore.annotation;

public class employeeNumber {

	public static void main(String[] args) {
		System.out.println(getNextNumber("0006"));
	}

	public static String getNextNumber(String num) {
		String nextNumber = String.valueOf(Integer.parseInt(num) + 1);
		int zeroCount = num.length() - nextNumber.length();
		for (int i = 0; i < zeroCount; i++) {
			nextNumber = "0" + nextNumber;
		}
		return nextNumber;
	}

}
