package com.example.demo.controller;

import com.example.demo.entity.KhachHang;
import com.example.demo.repository.KhachHangRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Date;
import java.util.regex.Pattern;

@Controller
public class RegisterController {

    @Autowired
    private KhachHangRepository khachHangRepository;

    private static final Pattern EMAIL_REGEX = Pattern.compile(
            "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
    );
    private static final Pattern PASSWORD_REGEX = Pattern.compile(
            "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@.#$!%*?&])[A-Za-z\\d@.#$!%*?&]{8,15}$"
    );
    private static final Pattern PHONE_REGEX = Pattern.compile(
            "^(0|\\+84)(3[2-9]|5[2689]|7[0-9]|8[1-9]|9[0-9])\\d{7}$"
    );
    @GetMapping("/register")
    public String viewRegisterPage(@RequestParam(required = false) String success, Model model) {
        if (success != null) {
            model.addAttribute("successMessage", "✅ Đăng ký thành công! Hãy đăng nhập.");
        }
        return "khachhang/register";
    }

    @PostMapping("/register")
    public String registerUser(@RequestParam(required = false) String customerName,
                               @RequestParam(required = false) String password,
                               @RequestParam(required = false) String phoneNumber,
                               @RequestParam(required = false) String address,
                               @RequestParam(required = false) String email,
                               @RequestParam(required = false) String gender, // <-- Nhận gender dạng String
                               Model model, RedirectAttributes redirectAttributes) {

        boolean hasError = false;

        // Kiểm tra tên khách hàng
        if (customerName == null || customerName.trim().isEmpty()) {
            model.addAttribute("errorTenKhachHang", "⚠️ Tên khách hàng không được để trống!");
            hasError = true;
        }

        // Kiểm tra mật khẩu
        if (password == null || password.trim().isEmpty()) {
            model.addAttribute("errorPassword", "⚠️ Mật khẩu không được để trống!");
            hasError = true;
        } else if (!PASSWORD_REGEX.matcher(password).matches()) {
            model.addAttribute("errorPassword", "⚠️ Mật khẩu phải có 8-15 ký tự, gồm chữ hoa, chữ thường, số và ký tự đặc biệt (@.#$!%*?&).");
            hasError = true;
        }


        // Kiểm tra số điện thoại
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            model.addAttribute("errorSoDienThoai", "⚠️ Số điện thoại không được để trống!");
            hasError = true;
        } else if (!PHONE_REGEX.matcher(phoneNumber.trim()).matches()) {
            model.addAttribute("errorSoDienThoai", "⚠️ Số điện thoại không hợp lệ!");
            hasError = true;
        }

        // Kiểm tra địa chỉ
        if (address == null || address.trim().isEmpty()) {
            model.addAttribute("errorDiaChi", "⚠️ Địa chỉ không được để trống!");
            hasError = true;
        }

        // Kiểm tra email
        if (email == null || email.trim().isEmpty()) {
            model.addAttribute("errorEmail", "⚠️ Email không được để trống!");
            hasError = true;
        } else if (!EMAIL_REGEX.matcher(email.trim()).matches()) {
            model.addAttribute("errorEmail", "⚠️ Email không hợp lệ!");
            hasError = true;
        } else if (khachHangRepository.findByEmail(email.trim()) != null) {
            model.addAttribute("errorEmail", "⚠️ Email đã tồn tại!");
            hasError = true;
        }

        // Kiểm tra giới tính (Ép kiểu từ String -> Boolean)
        Boolean gioiTinh = null;
        if ("Male".equalsIgnoreCase(gender)) {
            gioiTinh = true;
        } else if ("Female".equalsIgnoreCase(gender)) {
            gioiTinh = false;
        } else {
            model.addAttribute("errorGioiTinh", "⚠️ Vui lòng chọn giới tính!");
            hasError = true;
        }

        if (hasError) {
            return "quanly/login/register";
        }

        // Lưu thông tin khách hàng mới vào database
        KhachHang newCustomer = new KhachHang();
        newCustomer.setTenKhachHang(customerName.trim());
        newCustomer.setEmail(email.trim());
        newCustomer.setMatKhau(password.trim()); // **Lưu mật khẩu trực tiếp, không mã hóa**
        newCustomer.setSoDienThoai(phoneNumber.trim());
        newCustomer.setDiaChi(address.trim());
        newCustomer.setGioiTinh(gioiTinh); // <-- Lưu Boolean vào DB
        newCustomer.setNgayTao(new Date());
        newCustomer.setTrangThai(1); // Đặt trạng thái mặc định là 1 (hoạt động)

        khachHangRepository.save(newCustomer);

        System.out.println("Đăng ký thành công: " + " - Email: " + newCustomer.getEmail());

        // Chuyển hướng về trang đăng nhập
        redirectAttributes.addFlashAttribute("successMessage", "✅ Đăng ký thành công! Hãy đăng nhập.");
        return "redirect:quanly/login";
    }
}
