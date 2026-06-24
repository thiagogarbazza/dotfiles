---
applyTo: '**/pom.xml'
description: 'Instruções específicas do Maven POM.xml'
---

# Diretrizes para organização de arquivos POM.xml

Quando eu pedir para você executar qualquer ação em um arquivo `pom.xml`, você deve seguir rigorosamente as regras abaixo.

## Princípios fundamentais

- Builds Maven DEVEM ser determinísticos, reprodutíveis e fáceis de entender.
- Configurações DEVEM ser explícitas, centralizadas, preferencialmente no pom parent/agregador.
- A clareza e a manutenção a longo prazo são prioridades máximas.
- DEVE utilizar o padrão kebab-case para nomear o projeto em `<groupId>`, seguindo a convenção de domínio invertido (ex: `com.empresa.projeto`).
- DEVE utilizar o padrão kebab-case para nomear o projeto em `<artifactId>`.

## Regras de organização

### 1. Regras para arquivos XML

- Use uma indentação consistente de *2 espaços* para cada nível hierárquico.
- Ordene os atributos de cada elemento em ordem alfabética.
- Remova comentários gerados automaticamente por IDEs.

### 2. Estrutura de projeto multi-módulo

```
app-parent/
├── app-backend/
│   ├── app-core/
│   ├── app-jobs/
│   └── app-rff/
└── app-frontend/
```

Em projetos multi-módulo, o arquivo `pom.xml` do módulo parent/agregador DEVE conter apenas as coordenadas do projeto, metadados, `<properties>`, `<dependencyManagement>`, e `<build>` (com `<pluginManagement>`).
As dependências e plugins específicos de cada módulo devem ser declarados nos arquivos `pom.xml` dos módulos filhos.

#### 2.1 Pom parent/agregador

- DEVE concentrar as propriedades de versões de dependências e plugins, usando o padrão `${dependency.nome-da-dependencia.version}` e `${plugin.nome-do-plugin.version}`.
- DEVE conter o bloco `<modules>` listando os módulos filhos.
- DEVE conter o bloco `<dependencyManagement>` para centralizar as versões das dependências.
- DEVE conter o bloco `<pluginManagement>` para centralizar as versões dos plugins.

#### 2.2 Poms dos módulos filhos

- DEVE declarar apenas as dependências e plugins específicos do módulo, sem versões hardcoded (com exceção das dependências internas).
- DEVE herdar as versões das dependências e plugins do pom parent/agregador.
- NÃO DEVE conter o bloco `<dependencyManagement>` ou `<pluginManagement>`, pois isso deve ser centralizado no pom parent/agregador.
- NÃO DEVE conter o bloco `<profiles>`, pois isso deve ser centralizado no pom parent/agregador.

### 3. Ordem dos Blocos Estruturais

Mantenha a estrutura do arquivo XML na seguinte ordem hierárquica principal:

1. `<modelVersion>`
2. `<parent>` (se aplicável)
3. Coordenadas do projeto (`<groupId>`, `<artifactId>`, `<version>`, `<packaging>`)
4. Metadados (`<name>`, `<description>`, `<url>`)
5. `<modules>` (em projetos multi-módulo)
6. `<properties>`
7. `<dependencyManagement>`
8. `<dependencies>`
9. `<build>` (com `<pluginManagement>` e `<plugins>`)
10. `<profiles>`

### 4. Organização das propriedades

- Propriedades DEVEM ser ordenadas alfabeticamente.
- Propriedades DEVEM ser agrupadas por tipo, separadas por linhas em branco.
  1. Grupo dependências (ex: `dependency.junit.version`, `dependency.spring.version`)
  2. Grupo jacoco (ex: `jacoco.append`, `jacoco.destFile`)
  3. Grupo maven (ex: `maven.compiler.source`, `maven.compiler.target`)
  4. Grupo plugins (ex: `plugin.compiler.version`, `plugin.surefire.version`)
  5. Grupo projeto (ex: `project.build.sourceEncoding`, `project.reporting.outputEncoding`)
  6. Grupo sonar (ex: `sonar.exclusions`, `sonar.host.url`)

### 5. Organização das dependências

- Dependências DEVEM ser ordenadas alfabeticamente primeiro por `<groupId>` e depois por `<artifactId>`.
- Dependências NÃO DEVEM possuir a tag `<scope>compile</scope>`, pois este já é o escopo padrão do Maven.
- DEVEM mover qualquer versão declarada diretamente (*hardcoded*) nas tags `<dependency>` para o bloco `<properties>` usando o padrão `${dependency.nome-da-dependencia.version}`.
  - DEVE utilizar o padrão kebbab-case para `nome-da-dependencia`.
  - Em caso de projetos multi-módulo, DEVE centralizar as versões das dependências no pom parent/agregador usando o bloco `<dependencyManagement>`.
  - Em caso de projetos multi-módulo, DEVE adicionar *hardcode* apenas as dependências internas do projeto.

### 6. Organização dos plugins

- Plugins DEVEM ser ordenados alfabeticamente primeiro por `<groupId>` e depois por `<artifactId>`.
- DEVEM mover qualquer versão declarada diretamente (*hardcoded*) nas tags `<plugin>` para o bloco `<properties>` usando o padrão `${plugin.nome-do-plugin.version}`.
  - DEVE utilizar o padrão kebbab-case para `nome-do-plugin`.
  - Em caso de projetos multi-módulo, DEVE centralizar as versões dos plugins no pom parent/agregador usando o bloco `<pluginManagement>`.

### 7. Organização dos profiles

- Profiles DEVEM ser ordenados alfabeticamente por `<id>`.
- Cada profile DEVE manter a mesma ordem hierárquica dos blocos estruturais mencionada anteriormente (dependências, plugins, etc).
- Cada profile DEVE apenas ativar ou desativar configurações específicas que não alterem o produto final do build.
  Como por exemplo um profile release que ative a geração de javadoc e sources.

> Não é recomendado o uso de profiles para configurar dependências ou plugins específicos de ambiente.
> Prefira usar perfis apenas para ativar ou desativar configurações específicas, mantendo as dependências e plugins organizados no nível principal do `pom.xml` (parent/agregador).

## Referências

- [Maven Naming Conventions](https://maven.apache.org/guides/mini/guide-naming-conventions.html)
- [Maven POM Reference](https://maven.apache.org/pom.html)
- [Maven Best Practices](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html)
- [Maven Multi-Module Projects](https://maven.apache.org/guides/mini/guide-multiple-modules.html)
