import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MiniCactpotExpectedValueCalculations {
	private static final List<Integer> NUMBER_LIST;
	static {
		var list = new ArrayList<Integer>();
		for (int i = 1; i <= 9; i++) {
			list.add(i);
		}
		NUMBER_LIST = Collections.unmodifiableList(list);
	}
	
	private static final Map<Integer, BigDecimal> PAYOUT_MAP;
	static {
		var map = new HashMap<Integer, BigDecimal>();
		map.put(6, BigDecimal.valueOf(10000));
		map.put(7, BigDecimal.valueOf(36));
		map.put(8, BigDecimal.valueOf(720));
		map.put(9, BigDecimal.valueOf(360));
		map.put(10, BigDecimal.valueOf(80));
		map.put(11, BigDecimal.valueOf(252));
		map.put(12, BigDecimal.valueOf(108));
		map.put(13, BigDecimal.valueOf(72));
		map.put(14, BigDecimal.valueOf(54));
		map.put(15, BigDecimal.valueOf(180));
		map.put(16, BigDecimal.valueOf(72));
		map.put(17, BigDecimal.valueOf(180));
		map.put(18, BigDecimal.valueOf(119));
		map.put(19, BigDecimal.valueOf(36));
		map.put(20, BigDecimal.valueOf(306));
		map.put(21, BigDecimal.valueOf(1080));
		map.put(22, BigDecimal.valueOf(144));
		map.put(23, BigDecimal.valueOf(1800));
		map.put(24, BigDecimal.valueOf(3600));
		PAYOUT_MAP = Collections.unmodifiableMap(map);
	}

	public static void main(String args[]) {
		// ===== 数字の組み合わせリストを作成する =====
		var selectedNumberList = new ArrayList<ArrayList<Integer>>();
		for (var firstNumber : NUMBER_LIST) {
			for (var secondNumber : NUMBER_LIST) {
				// 1,1,x 2,2,x　など同じ数字の組み合わせがあればスキップ
				if (firstNumber == secondNumber) { continue; }
				for (var thirdNumber : NUMBER_LIST) {
					// 1,2,1 1,2,2　など同じ数字の組み合わせがあればスキップ
					if (firstNumber == thirdNumber || secondNumber == thirdNumber) { continue; }

					// 1,2,3 と 3,2,1 など並び替えを行った時に同じ組み合わせになるものはスキップ
					var list = new ArrayList<Integer>();
					list.add(firstNumber);
					list.add(secondNumber);
					list.add(thirdNumber);
					Collections.sort(list);
					if (selectedNumberList.contains(list)) {
						continue;
					}
					selectedNumberList.add(list);
				}
			}
		}

		// ===== 数字の組み合わせリストから合計を算出して払い出し合計を求める =====
		var sumPayout = BigDecimal.ZERO;
		for (var list : selectedNumberList) {
			sumPayout = sumPayout.add(PAYOUT_MAP.get(list.stream().mapToInt(i -> i).sum()));
		}
	
		// ===== 払い出し合計の平均を求める =====
		var result = sumPayout.divide(BigDecimal.valueOf(selectedNumberList.size()), RoundingMode.HALF_UP);

		// ===== 結果出力 =====
		System.out.println("===== result : " + result);
	}
}
