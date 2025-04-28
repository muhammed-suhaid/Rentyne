import 'package:rentyne/model/car_model.dart';
import 'package:rentyne/resources/asset_manager.dart';

final List<Car> sampleCars = [
  const Car(
    id: '1',
    brand: 'BMW',
    name: 'BMW X5',
    imageUrl: ImageAssets.getStarted3,
    description: 'Luxury mid-size SUV with sporty handling and advanced tech.',
    isAvailable: 'true',
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
        'Premium electric sedan offering long range and fast acceleration.',
    isAvailable: 'true',
    createdAt: '2025-04-27',
    cost: '3000',
    rating: '4.5',
  ),
  const Car(
    id: '3',
    brand: 'Porsche',
    name: 'Porsche 911',
    imageUrl: ImageAssets.getStarted1,
    description: 'Iconic sports car known for performance and timeless design.',
    isAvailable: 'false',
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
        'Executive sedan blending luxury, comfort, and tech innovation.',
    isAvailable: 'true',
    createdAt: '2025-04-27',
    cost: '2000',
    rating: '4.1',
  ),
  const Car(
    id: '5',
    brand: 'BMW',
    name: 'BMW i8',
    imageUrl: ImageAssets.getStarted3,
    description: 'Futuristic plug-in hybrid sports car with striking looks.',
    isAvailable: 'false',
    createdAt: '2025-04-27',
    cost: '4000',
    rating: '4.3',
  ),
];
