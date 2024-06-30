import { Component, OnInit } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { PessoaService } from './pessoa.service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, CommonModule],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent implements OnInit {
  title = 'project-app';
  data: any;

  constructor(private pessoaService: PessoaService) { }

  ngOnInit() {
    this.fetchData();
  }

  fetchData() {
    this.pessoaService.getPessoa()
      .subscribe({
        next: (response) => {
          this.data = response;
          console.log(this.data);
        },
        error: (e) => console.error(e)
      });
  }
}
