package com.example.demo;

import java.math.BigDecimal;
import java.text.DecimalFormat;

public class FormatMoney {

    /**
     * Định dạng giá trị tiền kiểu double theo mẫu "###.### VND"
     * @param amount Giá trị tiền cần định dạng
     * @return Chuỗi tiền đã định dạng
     */
    public static String formatMoney(double amount) {
        DecimalFormat df = new DecimalFormat("#,### VND");
        return df.format(amount);
    }

    /**
     * Định dạng giá trị tiền kiểu BigDecimal theo mẫu "###.### VND"
     * @param amount Giá trị tiền cần định dạng
     * @return Chuỗi tiền đã định dạng
     */
    public static String formatMoney(BigDecimal amount) {
        DecimalFormat df = new DecimalFormat("#,### VND");
        return df.format(amount);
    }

    /**
     * Định dạng giá trị tiền kiểu long theo mẫu "###.### VND"
     * @param amount Giá trị tiền cần định dạng
     * @return Chuỗi tiền đã định dạng
     */
    public static String formatMoney(long amount) {
        DecimalFormat df = new DecimalFormat("#,### VND");
        return df.format(amount);
    }

    /**
     * Định dạng giá trị tiền kiểu String (chuyển sang double trước khi định dạng)
     * @param amount Chuỗi giá trị tiền cần định dạng
     * @return Chuỗi tiền đã định dạng
     */
    public static String formatMoney(String amount) {
        try {
            double value = Double.parseDouble(amount);
            return formatMoney(value);
        } catch (NumberFormatException e) {
            return "Invalid amount";  // Trả về thông báo nếu chuỗi không hợp lệ
        }
    }
}
