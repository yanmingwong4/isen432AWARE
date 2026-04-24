class QuizQuestion {
  final int id;
  final String questionEn;
  final String questionEs;
  final List<QuizOption> options;
  final int correctAnswerIndex;
  final String safetyTipEn;
  final String safetyTipEs;
  final String categoryEn;
  final String categoryEs;
  final String? iconEmoji;

  QuizQuestion({
    required this.id,
    required this.questionEn,
    required this.questionEs,
    required this.options,
    required this.correctAnswerIndex,
    required this.safetyTipEn,
    required this.safetyTipEs,
    required this.categoryEn,
    required this.categoryEs,
    this.iconEmoji,
  });

  String getQuestion(String language) =>
      language == 'en' ? questionEn : questionEs;

  String getSafetyTip(String language) =>
      language == 'en' ? safetyTipEn : safetyTipEs;

  String getCategory(String language) =>
      language == 'en' ? categoryEn : categoryEs;
}

class QuizOption {
  final String textEn;
  final String textEs;
  final bool isCorrect;

  QuizOption({
    required this.textEn,
    required this.textEs,
    required this.isCorrect,
  });

  String getText(String language) => language == 'en' ? textEn : textEs;
}

final List<QuizQuestion> allQuizQuestions = [
  // Category 1: Pre-Takeoff & General Safety
  QuizQuestion(
    id: 1,
    questionEn: 'When should your seatbelt be fastened?',
    questionEs: '¿Cuándo debe estar abrochado tu cinturón de seguridad?',
    categoryEn: 'Pre-Takeoff & General Safety',
    categoryEs: 'Seguridad Pre-Despegue',
    iconEmoji: '🔒',
    options: [
      QuizOption(
        textEn: 'Only during takeoff and landing',
        textEs: 'Solo durante despegue y aterrizaje',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'At all times when seated',
        textEs: 'En todo momento cuando estés sentado',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'Only if turbulence is expected',
        textEs: 'Solo si se espera turbulencia',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Never required at cruising altitude',
        textEs: 'Nunca requerido a altitud de crucero',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 1,
    safetyTipEn:
        'FAA recommends keeping your seatbelt fastened at all times to protect against clear-air turbulence, which can occur suddenly.',
    safetyTipEs:
        'La FAA recomienda mantener el cinturón abrochado en todo momento para protegerse contra la turbulencia en aire claro, que puede ocurrir repentinamente.',
  ),
  QuizQuestion(
    id: 2,
    questionEn: 'Why must your tray table be stowed for takeoff?',
    questionEs: '¿Por qué debe recogerse la bandeja para el despegue?',
    categoryEn: 'Pre-Takeoff & General Safety',
    categoryEs: 'Seguridad Pre-Despegue',
    iconEmoji: '🧳',
    options: [
      QuizOption(
        textEn: 'It reduces fuel consumption',
        textEs: 'Reduce el consumo de combustible',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'To prevent it from blocking evacuation routes',
        textEs: 'Para evitar que obstruya las rutas de evacuación',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'It improves aircraft balance',
        textEs: 'Mejora el equilibrio de la aeronave',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Airline policy only',
        textEs: 'Solo política de la aerolínea',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 1,
    safetyTipEn:
        'A stowed tray table ensures clear evacuation paths and prevents debris from becoming projectiles during turbulence or emergency maneuvers.',
    safetyTipEs:
        'Una bandeja recogida asegura rutas de evacuación claras y previene que los objetos se conviertan en proyectiles durante turbulencia.',
  ),
  QuizQuestion(
    id: 3,
    questionEn: 'Why do we enable "Airplane Mode" on phones?',
    questionEs: '¿Por qué activamos el "Modo Avión" en teléfonos?',
    categoryEn: 'Pre-Takeoff & General Safety',
    categoryEs: 'Seguridad Pre-Despegue',
    iconEmoji: '📱',
    options: [
      QuizOption(
        textEn: 'To save battery power',
        textEs: 'Para ahorrar energía de batería',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'To prevent interference with cockpit avionics',
        textEs: 'Para prevenir interferencia con los sistemas de aviónica',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'To prevent data roaming charges',
        textEs: 'Para prevenir cargos de roaming',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'It has no technical purpose',
        textEs: 'No tiene propósito técnico',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 1,
    safetyTipEn:
        'Airplane Mode prevents RF emissions that could interfere with critical navigation and communication systems in the cockpit.',
    safetyTipEs:
        'El Modo Avión previene emisiones que podrían interferir con sistemas críticos de navegación y comunicación en la cabina de mando.',
  ),
  QuizQuestion(
    id: 4,
    questionEn: 'Why keep window blinds open during takeoff and landing?',
    questionEs: '¿Por qué mantener las persianas abiertas durante despegue y aterrizaje?',
    categoryEn: 'Pre-Takeoff & General Safety',
    categoryEs: 'Seguridad Pre-Despegue',
    iconEmoji: '🪟',
    options: [
      QuizOption(
        textEn: 'For passenger comfort',
        textEs: 'Para comodidad del pasajero',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'To allow your eyes to adjust for emergency visibility',
        textEs: 'Para permitir que tus ojos se adapten para visibilidad de emergencia',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'To improve aerodynamics',
        textEs: 'Para mejorar la aerodinámica',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'There is no safety reason',
        textEs: 'No hay razón de seguridad',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 1,
    safetyTipEn:
        'Eye adaptation is critical during evacuation. If cabin lights fail, eyes adjusted to outside light can help identify exits.',
    safetyTipEs:
        'La adaptación de los ojos es crítica durante la evacuación. Si las luces fallan, los ojos adaptados pueden ayudar a identificar salidas.',
  ),
  QuizQuestion(
    id: 5,
    questionEn: 'What is the small black triangle above your window?',
    questionEs: '¿Qué es el pequeño triángulo negro sobre tu ventana?',
    categoryEn: 'Pre-Takeoff & General Safety',
    categoryEs: 'Seguridad Pre-Despegue',
    iconEmoji: '▲',
    options: [
      QuizOption(
        textEn: 'A decoration',
        textEs: 'Una decoración',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'A marker for the flight crew to check wing flaps and ice',
        textEs: 'Una marca para que la tripulación verifique los alerones y hielo',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'A pressure relief vent',
        textEs: 'Una ventila de alivio de presión',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'A camera for surveillance',
        textEs: 'Una cámara de vigilancia',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 1,
    safetyTipEn:
        'The black triangle is a reference point (chine) for flight crew to visually inspect the wing during flight for ice accumulation and mechanical issues.',
    safetyTipEs:
        'El triángulo negro es un punto de referencia para que la tripulación inspeccione visualmente el ala durante el vuelo.',
  ),
  QuizQuestion(
    id: 6,
    questionEn: 'Your phone falls into the seat mechanism. What do you do?',
    questionEs: '¿Tu teléfono cae en el mecanismo del asiento? ¿Qué haces?',
    categoryEn: 'Pre-Takeoff & General Safety',
    categoryEs: 'Seguridad Pre-Despegue',
    iconEmoji: '⚠️',
    options: [
      QuizOption(
        textEn: 'Recline the seat to find it',
        textEs: 'Reclina el asiento para encontrarlo',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Adjust the seat mechanism to retrieve it',
        textEs: 'Ajusta el mecanismo del asiento para recuperarlo',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Notify a flight attendant - DO NOT move the seat',
        textEs: 'Notifica a una azafata - NO muevas el asiento',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'Leave it - it will be found later',
        textEs: 'Déjalo - será encontrado más tarde',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 2,
    safetyTipEn:
        'Lithium batteries in phones can be crushed by seat mechanisms, causing fires. Flight attendants have procedures to safely retrieve items.',
    safetyTipEs:
        'Las baterías de litio en teléfonos pueden ser aplastadas por mecanismos del asiento, causando incendios. Las azafatas tienen procedimientos seguros.',
  ),

  // Category 2: Emergency Scenarios
  QuizQuestion(
    id: 7,
    questionEn: 'If smoke fills the cabin, where is the cleanest air?',
    questionEs: '¿Si el humo llena la cabina, dónde está el aire más limpio?',
    categoryEn: 'Emergency Scenarios',
    categoryEs: 'Escenarios de Emergencia',
    iconEmoji: '💨',
    options: [
      QuizOption(
        textEn: 'Near the ceiling',
        textEs: 'Cerca del techo',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'In the middle of the cabin',
        textEs: 'En el medio de la cabina',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Near the floor',
        textEs: 'Cerca del suelo',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'At the emergency exits',
        textEs: 'En las salidas de emergencia',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 2,
    safetyTipEn:
        'Smoke rises. Fresh air enters near floor level from the fuselage ventilation system. Always crouch or crawl low.',
    safetyTipEs:
        'El humo sube. El aire fresco entra cerca del suelo. Siempre agáchate o arrastra por el suelo.',
  ),
  QuizQuestion(
    id: 8,
    questionEn: 'In a decompression, who gets the oxygen mask first?',
    questionEs: '¿En una descompresión, quién obtiene la máscara de oxígeno primero?',
    categoryEn: 'Emergency Scenarios',
    categoryEs: 'Escenarios de Emergencia',
    iconEmoji: '😷',
    options: [
      QuizOption(
        textEn: 'Your child',
        textEs: 'Tu hijo',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Yourself',
        textEs: 'Tú mismo',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'An elderly passenger',
        textEs: 'Un pasajero mayor',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'A flight attendant',
        textEs: 'Una azafata',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 1,
    safetyTipEn:
        'You must secure your own oxygen first. You cannot help others if you are incapacitated.',
    safetyTipEs:
        'Debes asegurar tu propio oxígeno primero. No puedes ayudar a otros si estás incapacitado.',
  ),
  QuizQuestion(
    id: 9,
    questionEn: 'Should you use oxygen during an active cabin fire?',
    questionEs: '¿Debes usar oxígeno durante un incendio activo en la cabina?',
    categoryEn: 'Emergency Scenarios',
    categoryEs: 'Escenarios de Emergencia',
    iconEmoji: '🔥',
    options: [
      QuizOption(
        textEn: 'Yes, always',
        textEs: 'Sí, siempre',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Only if the fire is small',
        textEs: 'Solo si el incendio es pequeño',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'No - oxygen feeds fire and concentrates heat',
        textEs: 'No - el oxígeno alimenta el fuego y concentra el calor',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'It depends on the location',
        textEs: 'Depende de la ubicación',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 2,
    safetyTipEn:
        'Oxygen masks must never be used near fires. Evacuate immediately and crawl to an exit.',
    safetyTipEs:
        'Las máscaras de oxígeno nunca deben usarse cerca de incendios. Evacúa inmediatamente.',
  ),
  QuizQuestion(
    id: 10,
    questionEn: 'Fire alarm sounds and you have your laptop. What do you do?',
    questionEs: '¿La alarma de incendio suena y tienes tu laptop? ¿Qué haces?',
    categoryEn: 'Emergency Scenarios',
    categoryEs: 'Escenarios de Emergencia',
    iconEmoji: '💻',
    options: [
      QuizOption(
        textEn: 'Pack it carefully in your carry-on',
        textEs: 'Empácalo cuidadosamente en tu bolso',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Hold it while evacuating',
        textEs: 'Sostenlo mientras evacúas',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Drop it and evacuate immediately',
        textEs: 'Suéltalo y evacúa inmediatamente',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'Ask a flight attendant to hold it',
        textEs: 'Pídele a una azafata que lo sostunga',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 2,
    safetyTipEn:
        'In an emergency evacuation, every second counts. Leave all belongings behind. Your life is infinitely more valuable than any item.',
    safetyTipEs:
        'En una evacuación de emergencia, cada segundo cuenta. Deja todos tus pertenencias. Tu vida es más valiosa.',
  ),
  QuizQuestion(
    id: 11,
    questionEn: 'What is the purpose of the "Brace" position?',
    questionEs: '¿Cuál es el propósito de la posición de "Protección"?',
    categoryEn: 'Emergency Scenarios',
    categoryEs: 'Escenarios de Emergencia',
    iconEmoji: '🛂',
    options: [
      QuizOption(
        textEn: 'To stay comfortable during rough air',
        textEs: 'Para mantenerse cómodo durante aire turbulento',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'To reduce flailing and impact force',
        textEs: 'Para reducir el movimiento sin control y la fuerza de impacto',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'To prepare for takeoff',
        textEs: 'Para prepararse para el despegue',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'To prevent motion sickness',
        textEs: 'Para prevenir mareos',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 1,
    safetyTipEn:
        'The brace position (hands on head, elbows against ribs) protects your head and chest during emergency landings or crashes.',
    safetyTipEs:
        'La posición de protección protege tu cabeza y pecho durante aterrizajes de emergencia o accidentes.',
  ),
  QuizQuestion(
    id: 12,
    questionEn: 'Why must high heels be removed before using an evacuation slide?',
    questionEs: '¿Por qué deben removerse los tacones altos antes de usar una rampa de evacuación?',
    categoryEn: 'Emergency Scenarios',
    categoryEs: 'Escenarios de Emergencia',
    iconEmoji: '👠',
    options: [
      QuizOption(
        textEn: 'Passenger comfort',
        textEs: 'Comodidad del pasajero',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'They slow down the evacuation',
        textEs: 'Ralentizan la evacuación',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'They can puncture the slide, causing deflation',
        textEs: 'Pueden perforar la rampa, causando desinflamación',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'They damage the shoes',
        textEs: 'Dañan los zapatos',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 2,
    safetyTipEn:
        'Modern evacuation slides are made of coated fabric. A puncture causes rapid deflation, creating a dangerous situation for others below.',
    safetyTipEs:
        'Las rampas de evacuación son de tela. Una perforación causa desinflamación rápida, peligrosa para otros.',
  ),

  // Category 3: Exits & Evacuation
  QuizQuestion(
    id: 13,
    questionEn: 'How long do manufacturers have to prove full evacuation?',
    questionEs: '¿Cuánto tiempo tienen los fabricantes para demostrar evacuación completa?',
    categoryEn: 'Exits & Evacuation',
    categoryEs: 'Salidas y Evacuación',
    iconEmoji: '⏱️',
    options: [
      QuizOption(
        textEn: '30 seconds',
        textEs: '30 segundos',
        isCorrect: false,
      ),
      QuizOption(
        textEn: '60 seconds',
        textEs: '60 segundos',
        isCorrect: false,
      ),
      QuizOption(
        textEn: '90 seconds',
        textEs: '90 segundos',
        isCorrect: true,
      ),
      QuizOption(
        textEn: '120 seconds',
        textEs: '120 segundos',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 2,
    safetyTipEn:
        'FAA/EASA certification requires aircraft to evacuate all passengers in 90 seconds using only 50% of exits.',
    safetyTipEs:
        'La certificación FAA/EASA requiere evacuar a todos los pasajeros en 90 segundos usando solo 50% de las salidas.',
  ),
  QuizQuestion(
    id: 14,
    questionEn: 'If seated in an exit row, can you put bags under the seat in front?',
    questionEs: '¿Si estás sentado en una fila de salida, puedes poner bolsas debajo del asiento frontal?',
    categoryEn: 'Exits & Evacuation',
    categoryEs: 'Salidas y Evacuación',
    iconEmoji: '🚪',
    options: [
      QuizOption(
        textEn: 'Yes, if the aisle is clear',
        textEs: 'Sí, si el pasillo está despejado',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Only small bags',
        textEs: 'Solo bolsas pequeñas',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'No - it creates a trip hazard',
        textEs: 'No - crea un peligro de tropiezo',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'Only if the flight is short',
        textEs: 'Solo si el vuelo es corto',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 2,
    safetyTipEn:
        'Exit rows must be completely clear of obstacles. Even small bags can trip evacuating passengers, potentially causing injuries or deaths.',
    safetyTipEs:
        'Las filas de salida deben estar completamente despejadas. Incluso bolsas pequeñas pueden causar tropiezos durante la evacuación.',
  ),
  QuizQuestion(
    id: 15,
    questionEn: 'How do you know which way to turn an emergency exit door?',
    questionEs: '¿Cómo sabes en qué dirección girar la puerta de salida de emergencia?',
    categoryEn: 'Exits & Evacuation',
    categoryEs: 'Salidas y Evacuación',
    iconEmoji: '🔄',
    options: [
      QuizOption(
        textEn: 'Always counterclockwise',
        textEs: 'Siempre en sentido antihorario',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Follow the arrows on the door',
        textEs: 'Sigue las flechas en la puerta',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'Pull it outward',
        textEs: 'Tíralo hacia afuera',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Push down on the handle',
        textEs: 'Presiona el manija hacia abajo',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 1,
    safetyTipEn:
        'All emergency exit doors have printed arrows showing the correct direction to open them. Follow these instructions exactly.',
    safetyTipEs:
        'Todas las puertas de salida de emergencia tienen flechas que muestran la dirección correcta. Sigue estas instrucciones exactamente.',
  ),
  QuizQuestion(
    id: 16,
    questionEn: 'When jumping into a slide, what arm position is safest?',
    questionEs: '¿Cuando saltas a una rampa, qué posición de brazo es más segura?',
    categoryEn: 'Exits & Evacuation',
    categoryEs: 'Salidas y Evacuación',
    iconEmoji: '🛝',
    options: [
      QuizOption(
        textEn: 'Arms outstretched',
        textEs: 'Brazos extendidos',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Arms raised above head',
        textEs: 'Brazos levantados sobre la cabeza',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Arms crossed over chest',
        textEs: 'Brazos cruzados sobre el pecho',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'Hands on the slide',
        textEs: 'Manos en la rampa',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 2,
    safetyTipEn:
        'Crossing arms over chest protects your torso and allows faster movement down the slide. Outstretched arms can catch or break.',
    safetyTipEs:
        'Los brazos cruzados protegen tu torso y permiten movimiento más rápido. Los brazos extendidos pueden engancharse o romperse.',
  ),
  QuizQuestion(
    id: 17,
    questionEn: 'If visibility is zero, what tells you you\'ve reached an exit?',
    questionEs: '¿Si la visibilidad es cero, qué te indica que alcanzaste una salida?',
    categoryEn: 'Exits & Evacuation',
    categoryEs: 'Salidas y Evacuación',
    iconEmoji: '🌫️',
    options: [
      QuizOption(
        textEn: 'A loud alarm',
        textEs: 'Una alarma fuerte',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'A temperature change',
        textEs: 'Un cambio de temperatura',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Floor lighting changes color (red or more intense)',
        textEs: 'La iluminación del piso cambia de color (rojo o más intenso)',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'You hear crew members',
        textEs: 'Escuchas a miembros de la tripulación',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 2,
    safetyTipEn:
        'All aircraft have floor-level lighting that changes color near exits—typically red or a brighter color—to guide evacuees in zero visibility conditions.',
    safetyTipEs:
        'Todos los aviones tienen iluminación a nivel del suelo que cambia de color cerca de salidas para guiar a los evacuados.',
  ),
  QuizQuestion(
    id: 18,
    questionEn: 'Why check the window before opening an emergency exit?',
    questionEs: '¿Por qué verificar la ventana antes de abrir una salida de emergencia?',
    categoryEn: 'Exits & Evacuation',
    categoryEs: 'Salidas y Evacuación',
    iconEmoji: '🔥',
    options: [
      QuizOption(
        textEn: 'To ensure good weather',
        textEs: 'Para asegurar buen clima',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'To see if anyone is below',
        textEs: 'Para ver si hay alguien abajo',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'To ensure there is no fire or water on the other side',
        textEs: 'Para asegurar que no hay fuego o agua del otro lado',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'To signal for help',
        textEs: 'Para señalar pidiendo ayuda',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 2,
    safetyTipEn:
        'Opening an exit to a raging fire or water would be catastrophic. Always check the window/door area first for external hazards.',
    safetyTipEs:
        'Abrir una salida hacia un incendio o agua sería catastrófico. Siempre verifica primero si hay peligros externos.',
  ),

  // Category 4: Onboard Gear
  QuizQuestion(
    id: 19,
    questionEn: 'When do you inflate your life vest?',
    questionEs: '¿Cuándo inflas tu chaleco salvavidas?',
    categoryEn: 'Onboard Gear',
    categoryEs: 'Equipo a Bordo',
    iconEmoji: '🦺',
    options: [
      QuizOption(
        textEn: 'Immediately when you sit down',
        textEs: 'Inmediatamente cuando te sientas',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'When the "fasten seatbelts" sign illuminates',
        textEs: 'Cuando se enciende el signo de abrocharse los cinturones',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Only after exiting the aircraft',
        textEs: 'Solo después de salir de la aeronave',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'When the plane is on the water',
        textEs: 'Cuando el avión está en el agua',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 2,
    safetyTipEn:
        'Inflating your vest inside the cabin can trap you or prevent you from exiting. Inflate only after you are outside the aircraft.',
    safetyTipEs:
        'Inflar tu chaleco dentro de la cabina puede atraparte. Infla solo después de salir de la aeronave.',
  ),
  QuizQuestion(
    id: 20,
    questionEn: 'Why does every life vest have a whistle and light?',
    questionEs: '¿Por qué cada chaleco salvavidas tiene un silbato y una luz?',
    categoryEn: 'Onboard Gear',
    categoryEs: 'Equipo a Bordo',
    iconEmoji: '🔦',
    options: [
      QuizOption(
        textEn: 'For comfort',
        textEs: 'Para comodidad',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'To signal rescuers in dark or poor visibility',
        textEs: 'Para señalar a los rescatistas en condiciones oscuras o de poca visibilidad',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'To keep you awake in the water',
        textEs: 'Para mantenerte despierto en el agua',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'To scare away marine animals',
        textEs: 'Para espantar animales marinos',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 1,
    safetyTipEn:
        'The whistle carries for miles over water; the light makes you visible to rescue aircraft and ships. Use them conservatively to preserve battery and voice.',
    safetyTipEs:
        'El silbato se escucha a millas sobre el agua; la luz te hace visible. Úsalos conservadoramente.',
  ),
  QuizQuestion(
    id: 21,
    questionEn: 'Where can you find your specific aircraft\'s exit layout?',
    questionEs: '¿Dónde puedes encontrar el diseño específico de salidas de tu aeronave?',
    categoryEn: 'Onboard Gear',
    categoryEs: 'Equipo a Bordo',
    iconEmoji: '📋',
    options: [
      QuizOption(
        textEn: 'On the flight attendant\'s manifest',
        textEs: 'En el manifiesto de la azafata',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'The airline\'s website',
        textEs: 'El sitio web de la aerolínea',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'The Safety Card in your seat pocket',
        textEs: 'La Tarjeta de Seguridad en tu bolsillo',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'You have to ask a flight attendant',
        textEs: 'Tienes que preguntarle a una azafata',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 2,
    safetyTipEn:
        'The Safety Card shows YOUR aircraft model and exact exit locations. Review it before takeoff. It could save your life.',
    safetyTipEs:
        'La Tarjeta de Seguridad muestra tu modelo de aeronave. Revísala antes del despegue.',
  ),
  QuizQuestion(
    id: 22,
    questionEn: 'What is the minimum age to sit in an exit row?',
    questionEs: '¿Cuál es la edad mínima para sentarse en una fila de salida?',
    categoryEn: 'Onboard Gear',
    categoryEs: 'Equipo a Bordo',
    iconEmoji: '👧',
    options: [
      QuizOption(
        textEn: '12 years old',
        textEs: '12 años',
        isCorrect: false,
      ),
      QuizOption(
        textEn: '15 years old',
        textEs: '15 años',
        isCorrect: true,
      ),
      QuizOption(
        textEn: '18 years old',
        textEs: '18 años',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Any age if supervised',
        textEs: 'Cualquier edad si está supervisado',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 1,
    safetyTipEn:
        'FAA regulations prohibit passengers under 15 from sitting in exit rows. This ensures they can open emergency doors and assist in evacuation if needed.',
    safetyTipEs:
        'La regulación FAA prohíbe pasajeros menores de 15 años en filas de salida. Asegura que puedan abrir puertas de emergencia si es necesario.',
  ),
  QuizQuestion(
    id: 23,
    questionEn: 'Where is your life vest usually located?',
    questionEs: '¿Dónde se encuentra generalmente tu chaleco salvavidas?',
    categoryEn: 'Onboard Gear',
    categoryEs: 'Equipo a Bordo',
    iconEmoji: '🧵',
    options: [
      QuizOption(
        textEn: 'In the overhead bin',
        textEs: 'En el compartimiento superior',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Behind the seat in front of you',
        textEs: 'Detrás del asiento frente a ti',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Under or between your seat',
        textEs: 'Debajo o entre tu asiento',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'At the emergency exit',
        textEs: 'En la salida de emergencia',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 2,
    safetyTipEn:
        'Life vests are stored under or between seats on aircraft with water routes. Know where yours is before you need it.',
    safetyTipEs:
        'Los chalecos salvavidas se almacenan bajo o entre los asientos. Sabe dónde está el tuyo antes de necesitarlo.',
  ),
  QuizQuestion(
    id: 24,
    questionEn: 'Is a lap-child safer than a child in an approved car seat?',
    questionEs: '¿Un niño en regazo es más seguro que un niño en un asiento de auto aprobado?',
    categoryEn: 'Onboard Gear',
    categoryEs: 'Equipo a Bordo',
    iconEmoji: '👶',
    options: [
      QuizOption(
        textEn: 'Yes, close contact is safer',
        textEs: 'Sí, el contacto cercano es más seguro',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'No - approved car seats are required by FAA',
        textEs: 'No - los asientos de auto aprobados son requeridos por la FAA',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'It does not matter',
        textEs: 'No importa',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Only for flights longer than 4 hours',
        textEs: 'Solo para vuelos más largos de 4 horas',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 1,
    safetyTipEn:
        'The FAA strongly recommends separate seats for children in approved car seats. Lap-holding provides no protection during turbulence or emergency maneuvers.',
    safetyTipEs:
        'La FAA recomienda fuertemente asientos separados para niños. Sostener en regazo no proporciona protección.',
  ),
  QuizQuestion(
    id: 25,
    questionEn: 'What is the primary role of flight attendants?',
    questionEs: '¿Cuál es el rol principal de los asistentes de vuelo?',
    categoryEn: 'Onboard Gear',
    categoryEs: 'Equipo a Bordo',
    iconEmoji: '👨‍✈️',
    options: [
      QuizOption(
        textEn: 'Serving food and beverages',
        textEs: 'Servir comida y bebidas',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Checking boarding passes',
        textEs: 'Verificar tarjetas de embarque',
        isCorrect: false,
      ),
      QuizOption(
        textEn: 'Safety and evacuation coordination',
        textEs: 'Coordinación de seguridad y evacuación',
        isCorrect: true,
      ),
      QuizOption(
        textEn: 'Entertainment management',
        textEs: 'Gestión del entretenimiento',
        isCorrect: false,
      ),
    ],
    correctAnswerIndex: 2,
    safetyTipEn:
        'Flight attendants are trained safety professionals first. Their primary duty is passenger safety and emergency response, not service.',
    safetyTipEs:
        'Los asistentes de vuelo son profesionales de seguridad entrenados. Su deber principal es la seguridad y respuesta de emergencia.',
  ),
];
