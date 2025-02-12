package com.example.demo.services;

import com.example.demo.entity.OngQuan;
import com.example.demo.repository.OngQuanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OngQuanService {

    @Autowired
    private OngQuanRepository ongQuanRepository;

    public List<OngQuan> getAllOngQuan(){

        return  ongQuanRepository.findAll();
    }
}
