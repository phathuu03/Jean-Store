package com.example.demo.controller;

import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.regex.Pattern;

@Controller
public class RegisterController {

    @Autowired
    private UserRepository userRepository;

    private static final Pattern EMAIL_REGEX = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    private static final Pattern PHONE_REGEX = Pattern.compile("^0\\d{9,10}$");

    @GetMapping("/register")
    public String viewRegisterPage(@RequestParam(required = false) String success, Model model) {
        if (success != null) {
            model.addAttribute("successMessage", "✅ Đăng ký thành công! Hãy đăng nhập.");
        }
        return "khachang/login/register";
    }

    @PostMapping("/register")
    public String registerUser(@RequestParam(required = false) String customerName,
                               @RequestParam(required = false) String username,
                               @RequestParam(required = false) String password,
                               @RequestParam(required = false) String phoneNumber,
                               @RequestParam(required = false) String address,
                               @RequestParam(required = false) String email,
                               @RequestParam(required = false) String gender,
                               Model model, RedirectAttributes redirectAttributes) {

        boolean hasError = false;

        // Kiểm tra tên khách hàng
        if (customerName == null || customerName.trim().isEmpty()) {
            model.addAttribute("errorTenKhachHang", "⚠️ Tên khách hàng không được để trống!");
            hasError = true;
        }

        // Kiểm tra tên đăng nhập
        if (username == null || username.trim().isEmpty()) {
            model.addAttribute("errorTenDangNhap", "⚠️ Tên đăng nhập không được để trống!");
            hasError = true;
        } else if (userRepository.findByUsernameIgnoreCase(username.trim()) != null) {
            model.addAttribute("errorTenDangNhap", "⚠️ Tên đăng nhập đã tồn tại!");
            hasError = true;
        }

        // Kiểm tra mật khẩu
        if (password == null || password.trim().isEmpty()) {
            model.addAttribute("errorPassword", "⚠️ Mật khẩu không được để trống!");
            hasError = true;
        } else if (password.length() < 6) {
            model.addAttribute("errorPassword", "⚠️ Mật khẩu phải có ít nhất 6 ký tự!");
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
        } else if (userRepository.findByEmailIgnoreCase(email.trim()) != null) {
            model.addAttribute("errorEmail", "⚠️ Email đã tồn tại!");
            hasError = true;
        }

        // Kiểm tra giới tính
        if (gender == null || gender.trim().isEmpty()) {
            model.addAttribute("errorGioiTinh", "⚠️ Vui lòng chọn giới tính!");
            hasError = true;
        }

        if (hasError) {
            return "khachang/login/register";
        }

        // Lưu thông tin người dùng mới vào database
        User newUser = new User();
        newUser.setCustomerName(customerName.trim());
        newUser.setUsername(username.trim());
        newUser.setEmail(email.trim());
        newUser.setPassword(password.trim()); // **Lưu mật khẩu trực tiếp, không mã hóa**
        newUser.setPhoneNumber(phoneNumber.trim());
        newUser.setAddress(address.trim());
        newUser.setGender(gender.trim());
        newUser.setRole("user"); // Đặt mặc định role là "user"

        userRepository.save(newUser);

        System.out.println("Đăng ký thành công: " + newUser.getUsername() + " - Email: " + newUser.getEmail());

        // Chuyển hướng về trang đăng ký nhưng thêm ?success để hiển thị thông báo
        redirectAttributes.addFlashAttribute("successMessage", "✅ Đăng ký thành công! Hãy đăng nhập.");
        return "redirect:/login/user";
    }
}
