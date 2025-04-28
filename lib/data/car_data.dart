import 'package:rentyne/model/car_model.dart';
import 'package:rentyne/resources/asset_manager.dart';

final List<Car> sampleCars = [
  const Car(
    id: '1',
    brand: 'BMW',
    name: 'BMW M340i',
    imageUrl: ImageAssets.getStarted3,
    description:
        'The BMW M340i is a revolutionary plug-in hybrid sports car that combines futuristic design with outstanding performance. With its aerodynamic curves, scissor doors, and lightweight carbon-fiber structure, the i8 looks like it’s straight from the future. Powered by a twin-turbocharged engine and an electric motor, it delivers exhilarating speed with impressive efficiency. Step inside to experience a luxurious cabin filled with premium materials, advanced technology, and an eco-friendly spirit. Perfect for those who crave innovation, performance, and unmistakable style on every journey.',
    isAvailable: true,
    createdAt: '2025-04-27',
    cost: '2000',
    rating: '4.7',
  ),
  const Car(
    id: '2',
    brand: 'Tesla',
    name: 'Tesla Model S',
    imageUrl: ImageAssets.getStarted2,
    description:
        'The Tesla Model S is a revolutionary plug-in hybrid sports car that combines futuristic design with outstanding performance. With its aerodynamic curves, scissor doors, and lightweight carbon-fiber structure, the i8 looks like it’s straight from the future. Powered by a twin-turbocharged engine and an electric motor, it delivers exhilarating speed with impressive efficiency. Step inside to experience a luxurious cabin filled with premium materials, advanced technology, and an eco-friendly spirit. Perfect for those who crave innovation, performance, and unmistakable style on every journey.',
    isAvailable: true,
    createdAt: '2025-04-27',
    cost: '3000',
    rating: '4.5',
  ),
  const Car(
    id: '3',
    brand: 'Porsche',
    name: 'Porsche 911 GT3 RS',
    imageUrl: ImageAssets.getStarted1,
    description:
        'The Porsche 911 GT3 RS is a revolutionary plug-in hybrid sports car that combines futuristic design with outstanding performance. With its aerodynamic curves, scissor doors, and lightweight carbon-fiber structure, the i8 looks like it’s straight from the future. Powered by a twin-turbocharged engine and an electric motor, it delivers exhilarating speed with impressive efficiency. Step inside to experience a luxurious cabin filled with premium materials, advanced technology, and an eco-friendly spirit. Perfect for those who crave innovation, performance, and unmistakable style on every journey.',
    isAvailable: false,
    createdAt: '2025-04-27',
    cost: '2500',
    rating: '4.9',
  ),
  const Car(
    id: '4',
    brand: 'Benz',
    name: 'Mercedes-Benz E-Class',
    imageUrl: ImageAssets.getStarted2,
    description:
        'The Mercedes-Benz E-Class is a revolutionary plug-in hybrid sports car that combines futuristic design with outstanding performance. With its aerodynamic curves, scissor doors, and lightweight carbon-fiber structure, the i8 looks like it’s straight from the future. Powered by a twin-turbocharged engine and an electric motor, it delivers exhilarating speed with impressive efficiency. Step inside to experience a luxurious cabin filled with premium materials, advanced technology, and an eco-friendly spirit. Perfect for those who crave innovation, performance, and unmistakable style on every journey.',
    isAvailable: true,
    createdAt: '2025-04-27',
    cost: '2000',
    rating: '4.1',
  ),
  const Car(
    id: '5',
    brand: 'BMW',
    name: 'BMW M5',
    imageUrl: ImageAssets.getStarted3,
    description:
        'The BMW M5 is a revolutionary plug-in hybrid sports car that combines futuristic design with outstanding performance. With its aerodynamic curves, scissor doors, and lightweight carbon-fiber structure, the i8 looks like it’s straight from the future. Powered by a twin-turbocharged engine and an electric motor, it delivers exhilarating speed with impressive efficiency. Step inside to experience a luxurious cabin filled with premium materials, advanced technology, and an eco-friendly spirit. Perfect for those who crave innovation, performance, and unmistakable style on every journey.',
    isAvailable: false,
    createdAt: '2025-04-27',
    cost: '4000',
    rating: '4.3',
  )
];
