package lllr.test.breast.util;

import com.github.pagehelper.PageHelper;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


public final class ComUtils {
	//分页处理
	/*
	pageNum:页码
	pageSize:每页的记录数
	isAutoHandler:当页码超过实际页码时，是否自动处理，如果不自动处理则返回空数据
	 */
	public static void mybatisPageHelper(String pageNum,String pageSize)
	{
		int pn = ComUtils.isEmpty(pageNum)  ? 1 : Integer.parseInt(pageNum);
		int ps = ComUtils.isEmpty(pageSize) ? 20 : Integer.parseInt(pageSize);
		PageHelper.startPage(pn < 0 ? 1 : pn,ps < 0 ? 20 : ps);
	}

	public static String toDateFormat(Date date, String pattern) {
		if (date == null) return "";
		return new SimpleDateFormat(pattern).format(date);
	}

	public static boolean isNull(Object obj) {
		if (obj == null || "".equals(obj.toString())) {
			return true;
		} else {
			return false;
		}
	}
	
	public static boolean isEmpty(Object value) {
		if (isNull(value)) {
			return true;
		}

		if (value instanceof String) {
			String str = (String) value;
			if ("".equals(str.trim())) {
				return true;
			}
		} else if (value instanceof Collection) {
			Collection<?> c = (Collection<?>) value;
			if (c.isEmpty()) {
				return true;
			}
		} else if (value instanceof Map) {
			Map<?,?> map = (Map<?,?>) value;
			if (map.isEmpty()) {
				return true;
			}
		} else if (value instanceof Iterator) {
			Iterator<?> iter = (Iterator<?>) value;
			if (!iter.hasNext()) {
				return true;
			}
		} else if (value.getClass().isArray()) {
			Object[] objArr = (Object[]) value;
			if (objArr.length <= 0) {
				return true;
			}
		} else {
			if ("".equals(value.toString().trim())) {
				return true;
			}
		}

		return false;
	}
	
	public static <T> Collection<T> nullToEmptyList(Collection<T> list) {
		if (list == null) {
			return Collections.emptyList();
		}
		return list;
	}
	public static <T> Collection<T> nullToEmptySet(Collection<T> list) {
		if (list == null) {
			return Collections.emptySet();
		}
		return list;
	}
	public static <T, V> Map<T, V> nullToEmptyMap(Map<T, V> map) {
		if (map == null) {
			return Collections.emptyMap();
		}
		return map;
	}
	
	public static String nullToEmpty(String str){
		return (str == null) ? "" : str;
	}
	
	public static BigDecimal add(Number one, Number two) {
		return toBigDecimal(one).add(toBigDecimal(two));
	}
	
	public static BigDecimal toBigDecimal(Number obj) {
		if (obj != null) {
			return new BigDecimal(obj.toString());
		}
		return BigDecimal.ZERO;
	}
	
	public static BigDecimal toBigDecimal(Double obj) {
		if (obj != null) {
			return new BigDecimal(obj.toString());
		}
		return BigDecimal.ZERO;
	}
	
	public static Double toDouble(Double obj) {
		if (obj != null) {
			return obj;
		}
		return Double.parseDouble("0");
	}

    /**
     * 字符串转日期
     */
    public static Date strToDate(String dateStr , String formatStr){
    	if(null == formatStr || null == dateStr){
    		return null;
    	}
    	SimpleDateFormat format = new SimpleDateFormat(formatStr);
    	try {
    		return format.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
    }
   
    public static String toCurrency(Number value) {
    	if (value == null) { 
    		return "";
    	}
    	DecimalFormat ft = new DecimalFormat("##,##0.00");
    	return ft.format(value);
    }

    public static boolean isInOneMonth(Date from,Date to) {
		Calendar c = Calendar.getInstance();
		c.setTime(from);
		int m1 = c.get(Calendar.MONTH);
		
		c.setTime(from);
		int m2 = c.get(Calendar.MONTH);
		if (m1 == m2) return true;
		return false;
	}
}
