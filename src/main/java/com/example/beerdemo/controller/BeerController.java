package com.example.beerdemo.controller;

import com.example.beerdemo.model.Beer;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class BeerController {

    @GetMapping("/beers")
    public List<Beer> getBeers() {
        // Пример: просто отдаем статический список
        return List.of(
                new Beer(1L, "Harbin"),
                new Beer(2L, "Tsingtao"),
                new Beer(3L, "Hoegaarden")
        );
    }
}