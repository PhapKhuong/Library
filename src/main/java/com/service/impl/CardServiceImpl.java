package com.service.impl;

import com.bean.Card;
import com.repository.impl.CardRepositoryImpl;
import com.repository.itf.CardRepository;
import com.service.itf.CardService;

import java.util.List;

public class CardServiceImpl implements CardService {
    private CardRepository repository = new CardRepositoryImpl();

    @Override
    public List<Card> display() {
        return repository.display();
    }

    @Override
    public void create(Card card) {
        repository.create(card);
    }

    @Override
    public void update(String cardId) {
        repository.update(cardId);
    }

    @Override
    public List<Card> searchById(String id) {
        return repository.searchById(id);
    }
}
