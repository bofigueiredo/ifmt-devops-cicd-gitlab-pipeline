package br.edu.ifmt.cicd.pessoa;

import java.util.List;

import org.springframework.stereotype.Service;


@Service
public class PessoaService {

	private final PessoaRepository pessoaRepository;

	public PessoaService(PessoaRepository pessoaRepository) {
		this.pessoaRepository = pessoaRepository;
	}

	public List<Pessoa> findAll() {
		return pessoaRepository.findAll();
	}

}
