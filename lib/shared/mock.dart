import 'package:porco_eats/models/product.dart';

class Mocks {
  final List<Map<String, dynamic>> productsJson = [
    // =========================
    // LANCHES
    // =========================
    {
      'id': 1,
      'restaurant': 'Burger House',
      'name': 'X-Bacon Duplo',
      'imageUrl':
          'assets/images/porco_eats_images/products/xbaconburgerhouse.png',
      'price': 27.92,
      'category': 'Lanches',
      'avaliation': 4.8,
      'description':
          'Hambúrguer artesanal com dois discos de carne bovina, bacon crocante, queijo derretido, alface, tomate e molho especial da Burger House.',
    },
    {
      'id': 2,
      'restaurant': 'Burger House',
      'name': 'X-Burger',
      'imageUrl':
          'assets/images/porco_eats_images/products/xburguerburguerhouse.png',
      'price': 25.90,
      'category': 'Lanches',
      'avaliation': 4.7,
      'description':
          'Clássico hambúrguer da Burger House preparado com carne bovina, queijo derretido, alface, tomate e molho especial servido no pão macio.',
    },
    {
      'id': 3,
      'restaurant': 'Madrugon Lanches',
      'name': 'X-Salada',
      'imageUrl':
          'assets/images/porco_eats_images/products/xsaladamadrugonlanches.jpg',
      'price': 23.90,
      'category': 'Lanches',
      'avaliation': 4.6,
      'description':
          'Hambúrguer artesanal com carne bovina, queijo, presunto, alface, tomate e molho especial, servido no tradicional pão de lanche.',
    },
    {
      'id': 4,
      'restaurant': 'Madrugon Lanches',
      'name': 'X-Frango',
      'imageUrl':
          'assets/images/porco_eats_images/products/xfrangomadrugonlanches.png',
      'price': 26.90,
      'category': 'Lanches',
      'avaliation': 4.5,
      'description':
          'Sanduíche preparado com filé de frango, queijo derretido, alface, tomate e molho especial, servido no pão macio.',
    },
    {
      'id': 5,
      'restaurant': 'Poderoso da Terra',
      'name': 'X-Bacon Cabuloso',
      'imageUrl': 'assets/images/porco_eats_images/products/xbaconcabuloso.png',
      'price': 29.90,
      'category': 'Lanches',
      'avaliation': 4.9,
      'description':
          'Um hambúrguer caprichado com carne bovina, bastante bacon crocante, queijo derretido e molho especial da casa.',
    },
    {
      'id': 6,
      'restaurant': 'Poderoso da Terra',
      'name': 'X-Burger Supremo',
      'imageUrl':
          'assets/images/porco_eats_images/products/xburguersupremo.png',
      'price': 42.90,
      'category': 'Lanches',
      'avaliation': 4.8,
      'description':
          'Hambúrguer especial com carne bovina, queijo derretido e ingredientes selecionados para deixar o lanche ainda mais completo e saboroso.',
    },
    {
      'id': 7,
      'restaurant': 'Madrugon Lanches',
      'name': 'X-Egg',
      'imageUrl': 'assets/images/porco_eats_images/products/xegg.png',
      'price': 24.90,
      'category': 'Lanches',
      'avaliation': 4.5,
      'description':
          'Clássico X-Egg preparado com carne bovina, ovo, queijo derretido, alface, tomate e molho especial da casa.',
    },

    // =========================
    // PIZZAS
    // ==========================
    {
      'id': 8,
      'restaurant': 'Pizza do chef',
      'name': 'Pizza de Calabresa',
      'imageUrl': 'assets/images/porco_eats_images/products/pizzacalabresa.png',
      'price': 76.41,
      'category': 'Pizza',
      'avaliation': 4.7,
      'description':
          'Pizza de calabresa preparada com molho de tomate, queijo mussarela, rodelas de calabresa e orégano, assada até ficar dourada.',
    },
    {
      'id': 9,
      'restaurant': 'Pizza do chef',
      'name': 'Pizza de Mussarela',
      'imageUrl': 'assets/images/porco_eats_images/products/pizzamusarela.png',
      'price': 69.90,
      'category': 'Pizza',
      'avaliation': 4.6,
      'description':
          'Pizza clássica de mussarela com molho de tomate, bastante queijo mussarela e orégano, preparada com massa assada e bordas douradas.',
    },
    {
      'id': 10,
      'restaurant': 'Mamamia Pizzas',
      'name': 'Pizza de Frango com Catupiry 40cm',
      'imageUrl':
          'assets/images/porco_eats_images/products/pizzafrangocatupiry.png',
      'price': 91.90,
      'category': 'Pizza',
      'avaliation': 4.5,
      'description':
          'Pizza de 40cm com frango desfiado temperado, queijo mussarela e cremoso Catupiry, finalizada com orégano.',
    },
    {
      'id': 11,
      'restaurant': 'Mamamia Pizzas',
      'name': 'Pizza broto de chocolate 20cm',
      'imageUrl':
          'assets/images/porco_eats_images/products/pizzabrotochocolate.png',
      'price': 45.90,
      'category': 'Pizza',
      'avaliation': 4.5,
      'description':
          'Pizza broto de 20cm preparada com uma camada cremosa de chocolate, perfeita para finalizar a refeição com uma opção doce.',
    },

    // =========================
    // SUSHIS
    // =========================
    {
      'id': 12,
      'restaurant': 'Tokyo Express',
      'name': 'Combo Sushi 60 peças',
      'imageUrl': 'assets/images/porco_eats_images/products/sushi60pecas.png',
      'price': 95.12,
      'category': 'Sushi',
      'avaliation': 4.9,
      'description':
          'Combo com 60 peças variadas de sushi, preparado com ingredientes frescos e selecionados para uma experiência completa da culinária japonesa.',
    },
    {
      'id': 13,
      'restaurant': 'Tokyo Express',
      'name': 'Combo Sushi 20 peças',
      'imageUrl': 'assets/images/porco_eats_images/products/sushi20pecas.png',
      'price': 44.99,
      'category': 'Sushi',
      'description':
          'Combo com 20 peças variadas de sushi, ideal para uma refeição individual ou para experimentar diferentes sabores da culinária japonesa.',
    },
    {
      'id': 14,
      'restaurant': 'Love Sushi',
      'name': 'Barca sushi 60 peças',
      'imageUrl':
          'assets/images/porco_eats_images/products/barcasushi60pecas.jpg',
      'price': 176.23,
      'category': 'Sushi',
      'description':
          'Barca com 60 peças variadas de sushi, combinando diferentes preparos da culinária japonesa em uma opção perfeita para compartilhar.',
    },
    {
      'id': 15,
      'restaurant': 'Love Sushi',
      'name': 'Temaki 30cm Salmão',
      'imageUrl': 'assets/images/porco_eats_images/products/temaki.png',
      'price': 32.90,
      'category': 'Sushi',
      'description':
          'Temaki de 30cm recheado com salmão e ingredientes selecionados, preparado na hora e envolvido em alga nori.',
    },
    {
      'id': 16,
      'restaurant': 'Love Sushi',
      'name': 'Tempeiro de gingibre e wasabi 30g',
      'imageUrl':
          'assets/images/porco_eats_images/products/tempeirojapones.png',
      'price': 12.00,
      'category': 'Sushi',
      'description':
          'Porção de 30g de tempero japonês com gengibre e wasabi, ideal para acompanhar sushis, sashimis e outros pratos da culinária japonesa.',
    },

    // =========================
    // EXECUTIVOS
    // ==========================
    {
      'id': 17,
      'restaurant': 'Frango Grill',
      'name': 'Frango Grelhado com Arroz e Salada',
      'imageUrl': 'assets/images/porco_eats_images/products/frangogrelhado.png',
      'price': 42.90,
      'category': 'Executivos',
      'avaliation': 4.8,
      'description':
          'Prato executivo com filé de frango grelhado, arroz branco e salada fresca, uma combinação equilibrada para uma refeição completa.',
    },
    {
      'id': 18,
      'restaurant': 'Frango Grill',
      'name': 'Bice Acebolado com Arroz e Salada',
      'imageUrl': 'assets/images/porco_eats_images/products/bifeacebolado.jpg',
      'price': 40.90,
      'category': 'Executivos',
      'description':
          'Prato executivo com bife acebolado preparado na chapa, acompanhado de arroz branco e salada fresca.',
    },
    {
      'id': 19,
      'restaurant': 'TipTeams',
      'name': 'Peixe Grelhado com Arroz e Salada',
      'imageUrl': 'assets/images/porco_eats_images/products/peixegrelhado.png',
      'price': 49.90,
      'category': 'Executivos',
      'description':
          'Prato executivo com peixe grelhado, arroz branco e salada fresca, preparado para uma refeição leve e saborosa.',
    },
    {
      'id': 20,
      'restaurant': 'TipTeams',
      'name': 'Carne de Porco Assada com Arroz e Salada',
      'imageUrl':
          'assets/images/porco_eats_images/products/carneporcoassada.png',
      'price': 45.90,
      'category': 'Executivos',
      'description':
          'Prato executivo com carne de porco assada e bem temperada, acompanhada de arroz branco e salada fresca.',
    },

    // =========================
    //  PORÇÕES
    // ==========================
    {
      'id': 21,
      'restaurant': 'TipTeams',
      'name': 'Porção de Frango 400g',
      'imageUrl': 'assets/images/porco_eats_images/products/porcaodefrango.png',
      'avaliation': 4.9,
      'price': 44.90,
      'category': 'Porções',
      'description':
          'Porção de 400g de frango preparado e temperado, servida em tamanho ideal para compartilhar ou aproveitar como acompanhamento.',
    },
    {
      'id': 22,
      'restaurant': 'TipTeams',
      'name': 'Porção de Batata Frita 300g',
      'imageUrl':
          'assets/images/porco_eats_images/products/porcaobatatafrita.jpg',
      'avaliation': 4.8,
      'price': 29.90,
      'category': 'Porções',
      'description':
          'Porção de 300g de batatas fritas crocantes por fora e macias por dentro, perfeita para acompanhar seu pedido ou compartilhar.',
    },
    {
      'id': 23,
      'restaurant': 'Madrugon Lanches',
      'name': 'Porção de Iscas de Peixe 200g',
      'imageUrl': 'assets/images/porco_eats_images/products/iscaspeixe.png',
      'avaliation': 4.8,
      'price': 49.90,
      'category': 'Porções',
      'description':
          'Porção de 200g de iscas de peixe empanadas e douradas, crocantes por fora e macias por dentro, ideal para compartilhar.',
    },
    {
      'id': 24,
      'restaurant': 'Madrugon Lanches',
      'name': 'Porção de Nuggets 300g',
      'imageUrl': 'assets/images/porco_eats_images/products/porcaonugget.jpg',
      'avaliation': 4.8,
      'price': 39.90,
      'category': 'Porções',
      'description':
          'Porção de 300g de nuggets crocantes e dourados, uma opção prática para compartilhar ou acompanhar seu lanche.',
    },

    // =========================
    //  BEBIDAS
    // ==========================
    {
      'id': 25,
      'restaurant': 'Suco arte',
      'name': 'Coca cola 350ml',
      'imageUrl': 'assets/images/porco_eats_images/products/cocalata.png',
      'avaliation': 4.8,
      'price': 6.00,
      'category': 'Bebidas',
      'description':
          'Coca-Cola em lata de 350ml, gelada e refrescante para acompanhar seu lanche ou refeição.',
    },
    {
      'id': 26,
      'restaurant': 'Suco arte',
      'name': 'Coca cola 600ml',
      'imageUrl': 'assets/images/porco_eats_images/products/coca600.png',
      'avaliation': 4.8,
      'price': 12.00,
      'category': 'Bebidas',
      'description':
          'Coca-Cola em garrafa de 600ml, uma opção refrescante para acompanhar sua refeição.',
    },
    {
      'id': 27,
      'restaurant': 'Suco arte',
      'name': 'Suco de Laranja Natural 500ml',
      'imageUrl': 'assets/images/porco_eats_images/products/sucodelaranja.png',
      'avaliation': 4.8,
      'price': 8.00,
      'category': 'Bebidas',
      'description':
          'Suco de laranja natural de 500ml, preparado com laranjas selecionadas para oferecer um sabor fresco e naturalmente cítrico.',
    },
    {
      'id': 28,
      'restaurant': 'Suco arte',
      'name': 'Suco de Uva Natural 500ml',
      'imageUrl': 'assets/images/porco_eats_images/products/sucodeuva.png',
      'avaliation': 4.8,
      'price': 8.00,
      'category': 'Bebidas',
      'description':
          'Suco de uva natural de 500ml, preparado para oferecer um sabor frutado, refrescante e levemente adocicado.',
    },
    {
      'id': 29,
      'restaurant': 'Parkour Cafés',
      'name': 'Café Expresso 200ml',
      'imageUrl': 'assets/images/porco_eats_images/products/cafeparkour.png',
      'avaliation': 4.8,
      'price': 12.00,
      'category': 'Bebidas',
      'description':
          'Café expresso de 200ml, preparado com grãos selecionados e servido com aroma intenso e sabor marcante.',
    },
  ];

  final List<Product> fakeLoadingProducts = [
    // =========================
    // LANCHES
    // =========================
    Product(
      id: 1,
      restaurant: 'Burger House',
      name: 'X-Bacon Duplo',
      imageUrl:
          'assets/images/porco_eats_images/products/xbaconburgerhouse.png',
      price: 27.92,
      category: 'Lanches',
      rating: 4.8,
      description:
          'Hambúrguer artesanal com dois discos de carne bovina, bacon crocante, queijo derretido, alface, tomate e molho especial da Burger House.',
    ),
    Product(
      id: 2,
      restaurant: 'Burger House',
      name: 'X-Burger',
      imageUrl:
          'assets/images/porco_eats_images/products/xburguerburguerhouse.png',
      price: 25.90,
      category: 'Lanches',
      rating: 4.7,
      description:
          'Clássico hambúrguer da Burger House preparado com carne bovina, queijo derretido, alface, tomate e molho especial servido no pão macio.',
    ),
    Product(
      id: 3,
      restaurant: 'Madrugon Lanches',
      name: 'X-Salada',
      imageUrl:
          'assets/images/porco_eats_images/products/xsaladamadrugonlanches.jpg',
      price: 23.90,
      category: 'Lanches',
      rating: 4.6,
      description:
          'Hambúrguer artesanal com carne bovina, queijo, presunto, alface, tomate e molho especial, servido no tradicional pão de lanche.',
    ),
    Product(
      id: 4,
      restaurant: 'Madrugon Lanches',
      name: 'X-Frango',
      imageUrl:
          'assets/images/porco_eats_images/products/xfrangomadrugonlanches.png',
      price: 26.90,
      category: 'Lanches',
      rating: 4.5,
      description:
          'Sanduíche preparado com filé de frango, queijo derretido, alface, tomate e molho especial, servido no pão macio.',
    ),
    Product(
      id: 5,
      restaurant: 'Poderoso da Terra',
      name: 'X-Bacon Cabuloso',
      imageUrl: 'assets/images/porco_eats_images/products/xbaconcabuloso.png',
      price: 29.90,
      category: 'Lanches',
      rating: 4.9,
      description:
          'Um hambúrguer caprichado com carne bovina, bastante bacon crocante, queijo derretido e molho especial da casa.',
    ),
    Product(
      id: 6,
      restaurant: 'Poderoso da Terra',
      name: 'X-Burger Supremo',
      imageUrl: 'assets/images/porco_eats_images/products/xburguersupremo.png',
      price: 42.90,
      category: 'Lanches',
      rating: 4.8,
      description:
          'Hambúrguer especial com carne bovina, queijo derretido e ingredientes selecionados para deixar o lanche ainda mais completo e saboroso.',
    ),
    Product(
      id: 7,
      restaurant: 'Madrugon Lanches',
      name: 'X-Egg',
      imageUrl: 'assets/images/porco_eats_images/products/xegg.png',
      price: 24.90,
      category: 'Lanches',
      rating: 4.5,
      description:
          'Clássico X-Egg preparado com carne bovina, ovo, queijo derretido, alface, tomate e molho especial da casa.',
    ),

    // =========================
    // PIZZAS
    // =========================
    Product(
      id: 8,
      restaurant: 'Pizza do chef',
      name: 'Pizza de Calabresa',
      imageUrl: 'assets/images/porco_eats_images/products/pizzacalabresa.png',
      price: 76.41,
      category: 'Pizza',
      rating: 4.7,
      description:
          'Pizza de calabresa preparada com molho de tomate, queijo mussarela, rodelas de calabresa e orégano, assada até ficar dourada.',
    ),
    Product(
      id: 9,
      restaurant: 'Pizza do chef',
      name: 'Pizza de Mussarela',
      imageUrl: 'assets/images/porco_eats_images/products/pizzamusarela.png',
      price: 69.90,
      category: 'Pizza',
      rating: 4.6,
      description:
          'Pizza clássica de mussarela com molho de tomate, bastante queijo mussarela e orégano, preparada com massa assada e bordas douradas.',
    ),
    Product(
      id: 10,
      restaurant: 'Mamamia Pizzas',
      name: 'Pizza de Frango com Catupiry 40cm',
      imageUrl:
          'assets/images/porco_eats_images/products/pizzafrangocatupiry.png',
      price: 91.90,
      category: 'Pizza',
      rating: 4.5,
      description:
          'Pizza de 40cm com frango desfiado temperado, queijo mussarela e cremoso Catupiry, finalizada com orégano.',
    ),
    Product(
      id: 11,
      restaurant: 'Mamamia Pizzas',
      name: 'Pizza broto de chocolate 20cm',
      imageUrl:
          'assets/images/porco_eats_images/products/pizzabrotochocolate.png',
      price: 45.90,
      category: 'Pizza',
      rating: 4.5,
      description:
          'Pizza broto de 20cm preparada com uma camada cremosa de chocolate, perfeita para finalizar a refeição com uma opção doce.',
    ),

    // =========================
    // SUSHIS
    // =========================
    Product(
      id: 12,
      restaurant: 'Tokyo Express',
      name: 'Combo Sushi 60 peças',
      imageUrl:
          'assets/images/porco_eats_images/products/combosushi60pecas.png',
      price: 95.12,
      category: 'Sushi',
      rating: 4.9,
      description:
          'Combo com 60 peças variadas de sushi, preparado com ingredientes frescos e selecionados para uma experiência completa da culinária japonesa.',
    ),
    Product(
      id: 13,
      restaurant: 'Tokyo Express',
      name: 'Combo Sushi 20 peças',
      imageUrl: 'assets/images/porco_eats_images/products/sushi20pecas.png',
      price: 44.99,
      category: 'Sushi',
      rating: 4.7,
      description:
          'Combo com 20 peças variadas de sushi, ideal para uma refeição individual ou para experimentar diferentes sabores da culinária japonesa.',
    ),
    Product(
      id: 14,
      restaurant: 'Love Sushi',
      name: 'Barca sushi 60 peças',
      imageUrl:
          'assets/images/porco_eats_images/products/barcasushi60pecas.jpg',
      price: 176.23,
      category: 'Sushi',
      rating: 4.8,
      description:
          'Barca com 60 peças variadas de sushi, combinando diferentes preparos da culinária japonesa em uma opção perfeita para compartilhar.',
    ),
    Product(
      id: 15,
      restaurant: 'Love Sushi',
      name: 'Temaki 30cm Salmão',
      imageUrl: 'assets/images/porco_eats_images/products/temaki.png',
      price: 32.90,
      category: 'Sushi',
      rating: 4.7,
      description:
          'Temaki de 30cm recheado com salmão e ingredientes selecionados, preparado na hora e envolvido em alga nori.',
    ),
    Product(
      id: 16,
      restaurant: 'Love Sushi',
      name: 'Tempeiro de gingibre e wasabi 30g',
      imageUrl: 'assets/images/porco_eats_images/products/tempeirojapones.png',
      price: 12.00,
      category: 'Sushi',
      rating: 4.5,
      description:
          'Porção de 30g de tempero japonês com gengibre e wasabi, ideal para acompanhar sushis, sashimis e outros pratos da culinária japonesa.',
    ),

    // =========================
    // EXECUTIVOS
    // =========================
    Product(
      id: 17,
      restaurant: 'Frango Grill',
      name: 'Frango Grelhado com Arroz e Salada',
      imageUrl: 'assets/images/porco_eats_images/products/frangogrelhado.png',
      price: 42.90,
      category: 'Executivos',
      rating: 4.8,
      description:
          'Prato executivo com filé de frango grelhado, arroz branco e salada fresca, uma combinação equilibrada para uma refeição completa.',
    ),
    Product(
      id: 18,
      restaurant: 'Frango Grill',
      name: 'Bice Acebolado com Arroz e Salada',
      imageUrl: 'assets/images/porco_eats_images/products/bifeacebolado.jpg',
      price: 40.90,
      category: 'Executivos',
      rating: 4.7,
      description:
          'Prato executivo com bife acebolado preparado na chapa, acompanhado de arroz branco e salada fresca.',
    ),
    Product(
      id: 19,
      restaurant: 'TipTeams',
      name: 'Peixe Grelhado com Arroz e Salada',
      imageUrl: 'assets/images/porco_eats_images/products/peixegrelhado.png',
      price: 49.90,
      category: 'Executivos',
      rating: 4.6,
      description:
          'Prato executivo com peixe grelhado, arroz branco e salada fresca, preparado para uma refeição leve e saborosa.',
    ),
    Product(
      id: 20,
      restaurant: 'TipTeams',
      name: 'Carne de Porco Assada com Arroz e Salada',
      imageUrl: 'assets/images/porco_eats_images/products/carneporcoassada.png',
      price: 45.90,
      category: 'Executivos',
      rating: 4.8,
      description:
          'Prato executivo com carne de porco assada e bem temperada, acompanhada de arroz branco e salada fresca.',
    ),

    // =========================
    // PORÇÕES
    // =========================
    Product(
      id: 21,
      restaurant: 'TipTeams',
      name: 'Porção de Frango 400g',
      imageUrl: 'assets/images/porco_eats_images/products/porcaodefrango.png',
      price: 44.90,
      category: 'Executivos',
      rating: 4.9,
      description:
          'Porção de 400g de frango preparado e temperado, servida em tamanho ideal para compartilhar ou aproveitar como acompanhamento.',
    ),
    Product(
      id: 22,
      restaurant: 'TipTeams',
      name: 'Porção de Batata Frita 300g',
      imageUrl:
          'assets/images/porco_eats_images/products/porcaobatatafrita.jpg',
      price: 29.90,
      category: 'Porções',
      rating: 4.8,
      description:
          'Porção de 300g de batatas fritas crocantes por fora e macias por dentro, perfeita para acompanhar seu pedido ou compartilhar.',
    ),
    Product(
      id: 23,
      restaurant: 'Madrugon Lanches',
      name: 'Porção de Iscas de Peixe 200g',
      imageUrl: 'assets/images/porco_eats_images/products/iscaspeixe.png',
      price: 49.90,
      category: 'Porções',
      rating: 4.8,
      description:
          'Porção de 200g de iscas de peixe empanadas e douradas, crocantes por fora e macias por dentro, ideal para compartilhar.',
    ),
    Product(
      id: 24,
      restaurant: 'Madrugon Lanches',
      name: 'Porção de Nuggets 300g',
      imageUrl: 'assets/images/porco_eats_images/products/porcaonugget.jpg',
      price: 39.90,
      category: 'Porções',
      rating: 4.8,
      description:
          'Porção de 300g de nuggets crocantes e dourados, uma opção prática para compartilhar ou acompanhar seu lanche.',
    ),

    // =========================
    // BEBIDAS
    // =========================
    Product(
      id: 25,
      restaurant: 'Suco arte',
      name: 'Coca cola 350ml',
      imageUrl: 'assets/images/porco_eats_images/products/cocalata.png',
      price: 6.00,
      category: 'Bebidas',
      rating: 4.8,
      description:
          'Coca-Cola em lata de 350ml, gelada e refrescante para acompanhar seu lanche ou refeição.',
    ),
    Product(
      id: 26,
      restaurant: 'Suco arte',
      name: 'Coca cola 600ml',
      imageUrl: 'assets/images/porco_eats_images/products/coca600.png',
      price: 12.00,
      category: 'Bebidas',
      rating: 4.8,
      description:
          'Coca-Cola em garrafa de 600ml, uma opção refrescante para acompanhar sua refeição.',
    ),
    Product(
      id: 27,
      restaurant: 'Suco arte',
      name: 'Suco de Laranja Natural 500ml',
      imageUrl: 'assets/images/porco_eats_images/products/sucodelaranja.png',
      price: 8.00,
      category: 'Bebidas',
      rating: 4.8,
      description:
          'Suco de laranja natural de 500ml, preparado com laranjas selecionadas para oferecer um sabor fresco e naturalmente cítrico.',
    ),
    Product(
      id: 28,
      restaurant: 'Suco arte',
      name: 'Suco de Uva Natural 500ml',
      imageUrl: 'assets/images/porco_eats_images/products/sucodeuva.png',
      price: 8.00,
      category: 'Bebidas',
      rating: 4.8,
      description:
          'Suco de uva natural de 500ml, preparado para oferecer um sabor frutado, refrescante e levemente adocicado.',
    ),
    Product(
      id: 29,
      restaurant: 'Parkour Cafés',
      name: 'Café Expresso 200ml',
      imageUrl: 'assets/images/porco_eats_images/products/cafeparkour.png',
      price: 12.00,
      category: 'Bebidas',
      rating: 4.8,
      description:
          'Café expresso de 200ml, preparado com grãos selecionados e servido com aroma intenso e sabor marcante.',
    ),
  ];
}
