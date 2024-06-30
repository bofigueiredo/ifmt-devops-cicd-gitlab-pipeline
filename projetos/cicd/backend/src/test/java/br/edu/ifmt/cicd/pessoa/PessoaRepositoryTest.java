package br.edu.ifmt.cicd.pessoa;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;


@SpringBootTest
@ActiveProfiles("test")
class PessoaRepositoryTest {

	@Autowired
    private PessoaRepository pessoaRepository;

    @Test
    public void testFindById() {
        pessoaRepository.save(new Pessoa(null, "Bruno", "bofigueiredo@gmail.com"));

        Pessoa pessoaEncontrada = pessoaRepository.findById(1L).orElse(null);
        assertNotNull(pessoaEncontrada, "Pessoa não encontrada");
        assertEquals("Bruno", pessoaEncontrada.getNome(), "Nome da pessoa não corresponde");
    }

}
