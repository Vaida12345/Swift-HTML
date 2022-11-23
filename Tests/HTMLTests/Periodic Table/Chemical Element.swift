//
//  Chemical Element.swift
//  
//
//  Created by Vaida on 11/23/22.
//


public struct ChemicalElement {
    
    // MARK: - Basic Properties
    
    public let atomicNumber: Int
    
    public let name: String
    
    public let symbol: String
    
    public let molarMass: Double
    
    public let group: Int?
    
    public let period: Int
    
    public let classification: Classification
    
    public let block: Block
    
    
    // MARK: - Instance Properties
    
    public var position: (x: Int, y: Int) {
        if let group {
            return (group, period)
        } else {
            if self.classification == .lanthanide {
                return (self.atomicNumber - 55 + 2, period + 2)
            } else if self.classification == .actinide {
                return (self.atomicNumber - 87 + 2, period + 2)
            } else {
                fatalError()
            }
        }
    }
    
    // MARK: - Instance Methods
    
    
    // MARK: - Designated Initializers
    
    private init(_ atomicNumber: Int, _ name: String, _ symbol: String, _ molarMass: Double, group: Int?, period: Int, _ classification: Classification, block: Block) {
        self.atomicNumber = atomicNumber
        self.name = name
        self.symbol = symbol
        self.molarMass = molarMass
        self.group = group
        self.period = period
        self.classification = classification
        self.block = block
    }
    
    
    // MARK: - Initializers
    
    
    // MARK: - Type Properties
    
    public static let allCases: [ChemicalElement] = [
        ChemicalElement(1,   "Hydrogen",      "H",   1.0080,   group: 1,   period: 1, .none,                block: .s),
        ChemicalElement(2,   "Helium",        "He",  4.0026,   group: 18,  period: 1, .nobleGas,            block: .s),
          
          
        ChemicalElement(3,   "Lithium",       "Li",  6.94,     group: 1,   period: 2, .alkaliMetal,         block: .s),
        ChemicalElement(4,   "Beryllium",     "Be",  9.0122,   group: 2,   period: 2, .alkalineEarthMetal,  block: .s),
          
        ChemicalElement(5,   "Boron",         "B",   10.81,    group: 13,  period: 2, .metalloid,           block: .p),
        ChemicalElement(6,   "Carbon",        "C",   12.0107,  group: 14,  period: 2, .nonmetal,            block: .p),
        ChemicalElement(7,   "Nitrogen",      "N",   14.0067,  group: 15,  period: 2, .nonmetal,            block: .p),
        ChemicalElement(8,   "Oxygen",        "O",   15.9994,  group: 16,  period: 2, .nonmetal,            block: .p),
        ChemicalElement(9,   "Fluorine",      "F",   18.9984,  group: 17,  period: 2, .halogen,             block: .p),
        ChemicalElement(10,  "Neon",          "Ne",  20.1797,  group: 18,  period: 2, .nobleGas,            block: .p),
          
          
        ChemicalElement(11,  "Sodium",        "Na",  22.9897,  group: 1,   period: 3, .alkaliMetal,         block: .s),
        ChemicalElement(12,  "Magnesium",     "Mg",  24.3050,  group: 2,   period: 3, .alkalineEarthMetal,  block: .s),
          
        ChemicalElement(13,  "Aluminium",     "Al",  26.9815,  group: 13,  period: 3, .postTransitionMetal, block: .p),
        ChemicalElement(14,  "Silicon",       "Si",  28.0855,  group: 14,  period: 3, .metalloid,           block: .p),
        ChemicalElement(15,  "Phosphorus",    "P",   30.9737,  group: 15,  period: 3, .nonmetal,            block: .p),
        ChemicalElement(16,  "Sulfur",        "S",   32.065,   group: 16,  period: 3, .nonmetal,            block: .p),
        ChemicalElement(17,  "Chlorine",      "Cl",  35.453,   group: 17,  period: 3, .halogen,             block: .p),
        ChemicalElement(18,  "Argon",         "Ar",  39.948,   group: 18,  period: 3, .nobleGas,            block: .p),
          
          
        ChemicalElement(19,  "Potassium",     "K",   39.0983,  group: 1,   period: 4, .alkaliMetal,         block: .s),
        ChemicalElement(20,  "Calcium",       "Ca",  40.078,   group: 2,   period: 4, .alkalineEarthMetal,  block: .s),
          
        ChemicalElement(21,  "Scandium",      "Sc",  44.9559,  group: 3,   period: 4, .transitionMetal,     block: .d),
        ChemicalElement(22,  "Titanium",      "Ti",  47.867,   group: 4,   period: 4, .transitionMetal,     block: .d),
        ChemicalElement(23,  "Vanadium",      "V",   50.9415,  group: 5,   period: 4, .transitionMetal,     block: .d),
        ChemicalElement(24,  "Chromium",      "Cr",  51.9961,  group: 6,   period: 4, .transitionMetal,     block: .d),
        ChemicalElement(25,  "Manganese",     "Mn",  54.9380,  group: 7,   period: 4, .transitionMetal,     block: .d),
        ChemicalElement(26,  "Iron",          "Fe",  55.845,   group: 8,   period: 4, .transitionMetal,     block: .d),
        ChemicalElement(27,  "Cobalt",        "Co",  58.9331,  group: 9,   period: 4, .transitionMetal,     block: .d),
        ChemicalElement(28,  "Nickel",        "Ni",  58.6934,  group: 10,  period: 4, .transitionMetal,     block: .d),
        ChemicalElement(29,  "Copper",        "Cu",  63.546,   group: 11,  period: 4, .transitionMetal,     block: .d),
        ChemicalElement(30,  "Zinc",          "Zn",  65.409,   group: 12,  period: 4, .transitionMetal,     block: .d),
          
        ChemicalElement(31,  "Gallium",       "Ga",  69.723,   group: 13,  period: 4, .postTransitionMetal, block: .p),
        ChemicalElement(32,  "Germanium",     "Ge",  72.64,    group: 14,  period: 4, .metalloid,           block: .p),
        ChemicalElement(33,  "Arsenic",       "As",  74.9216,  group: 15,  period: 4, .metalloid,           block: .p),
        ChemicalElement(34,  "Selenium",      "Se",  78.96,    group: 16,  period: 4, .nonmetal,            block: .p),
        ChemicalElement(35,  "Bromine",       "Br",  79.904,   group: 17,  period: 4, .halogen,             block: .p),
        ChemicalElement(36,  "Krypton",       "Kr",  83.798,   group: 18,  period: 4, .nobleGas,            block: .p),
          
          
        ChemicalElement(37,  "Rubidium",      "Rb",  85.467,   group: 1,   period: 5, .alkaliMetal,         block: .s),
        ChemicalElement(38,  "Strontium",     "Sr",  87.62,    group: 2,   period: 5, .alkalineEarthMetal,  block: .s),
          
        ChemicalElement(39,  "Yttrium",       "Y",   88.905,   group: 3,   period: 5, .transitionMetal,     block: .d),
        ChemicalElement(40,  "Zirconium",     "Zr",  91.224,   group: 4,   period: 5, .transitionMetal,     block: .d),
        ChemicalElement(41,  "Niobium",       "Nb",  92.906,   group: 5,   period: 5, .transitionMetal,     block: .d),
        ChemicalElement(42,  "Molybdenum",    "Mo",  95.94,    group: 6,   period: 5, .transitionMetal,     block: .d),
        ChemicalElement(43,  "Technetium",    "Tc",  98.906,   group: 7,   period: 5, .transitionMetal,     block: .d),
        ChemicalElement(44,  "Ruthenium",     "Ru",  101.07,   group: 8,   period: 5, .transitionMetal,     block: .d),
        ChemicalElement(45,  "Rhodium",       "Rh",  102.905,  group: 9,   period: 5, .transitionMetal,     block: .d),
        ChemicalElement(46,  "Palladium",     "Pd",  106.42,   group: 10,  period: 5, .transitionMetal,     block: .d),
        ChemicalElement(47,  "Silver",        "Ag",  107.868,  group: 11,  period: 5, .transitionMetal,     block: .d),
        ChemicalElement(48,  "Cadmium",       "Cd",  112.411,  group: 12,  period: 5, .transitionMetal,     block: .d),
          
        ChemicalElement(49,  "Indium",        "In",  114.818,  group: 13,  period: 5, .postTransitionMetal, block: .p),
        ChemicalElement(50,  "Tin",           "Sn",  118.710,  group: 14,  period: 5, .postTransitionMetal, block: .p),
        ChemicalElement(51,  "Antimony",      "Sb",  121.760,  group: 15,  period: 5, .metalloid,           block: .p),
        ChemicalElement(52,  "Tellurium",     "Te",  127.60,   group: 16,  period: 5, .metalloid,           block: .p),
        ChemicalElement(53,  "Iodine",        "I",   126.904,  group: 17,  period: 5, .halogen,             block: .p),
        ChemicalElement(54,  "Xenon",         "Xe",  131.293,  group: 18,  period: 5, .nonmetal,            block: .p),
          
        ChemicalElement(55,  "Caesium",       "Cs",  132.905,  group: 1,   period: 6, .alkaliMetal,         block: .s),
        ChemicalElement(56,  "Barium",        "Ba",  137.327,  group: 2,   period: 6, .alkalineEarthMetal,  block: .s),
         
        ChemicalElement(57,  "Lanthanum",     "La",  138.905,  group: nil, period: 6, .lanthanide,          block: .f),
        ChemicalElement(58,  "Cerium",        "Ce",  140.116,  group: nil, period: 6, .lanthanide,          block: .f),
        ChemicalElement(59,  "Praseodymium",  "Pr",  140.904,  group: nil, period: 6, .lanthanide,          block: .f),
        ChemicalElement(60,  "Neodymium",     "Nd",  144.242,  group: nil, period: 6, .lanthanide,          block: .f),
        ChemicalElement(61,  "Promethium",    "Pm",  146.915,  group: nil, period: 6, .lanthanide,          block: .f),
        ChemicalElement(62,  "Samarium",      "Sm",  150.36,   group: nil, period: 6, .lanthanide,          block: .f),
        ChemicalElement(63,  "Europium",      "Eu",  151.964,  group: nil, period: 6, .lanthanide,          block: .f),
        ChemicalElement(64,  "Gadolinium",    "Gd",  157.25,   group: nil, period: 6, .lanthanide,          block: .f),
        ChemicalElement(65,  "Terbium",       "Tb",  158.925,  group: nil, period: 6, .lanthanide,          block: .f),
        ChemicalElement(66,  "Dysprosium",    "Dy",  162.500,  group: nil, period: 6, .lanthanide,          block: .f),
        ChemicalElement(67,  "Holmium",       "Ho",  164.93,   group: nil, period: 6, .lanthanide,          block: .f),
        ChemicalElement(68,  "Erbium",        "Er",  167.259,  group: nil, period: 6, .lanthanide,          block: .f),
        ChemicalElement(69,  "Thulium",       "Tm",  168.934,  group: nil, period: 6, .lanthanide,          block: .f),
        ChemicalElement(70,  "Ytterbium",     "Yb",  173.04,   group: nil, period: 6, .lanthanide,          block: .f),
        ChemicalElement(71,  "Lutetium",      "Lu",  174.967,  group: nil, period: 6, .lanthanide,          block: .d),
        
        ChemicalElement(72,  "Hafnium",       "Hf",  178.49,   group: 4,   period: 6, .transitionMetal,     block: .d),
        ChemicalElement(73,  "Tantalum",      "Ta",  180.947,  group: 5,   period: 6, .transitionMetal,     block: .d),
        ChemicalElement(74,  "Tungsten",      "W",   183.84,   group: 6,   period: 6, .transitionMetal,     block: .d),
        ChemicalElement(75,  "Rhenium",       "Re",  186.207,  group: 7,   period: 6, .transitionMetal,     block: .d),
        ChemicalElement(76,  "Osmium",        "Os",  190.23,   group: 8,   period: 6, .transitionMetal,     block: .d),
        ChemicalElement(77,  "Iridium",       "Ir",  192.217,  group: 9,   period: 6, .transitionMetal,     block: .d),
        ChemicalElement(78,  "Platinum",      "Pt",  195.084,  group: 10,  period: 6, .transitionMetal,     block: .d),
        ChemicalElement(79,  "Gold",          "Au",  196.966,  group: 11,  period: 6, .transitionMetal,     block: .d),
        ChemicalElement(80,  "Mercury",       "Hg",  200.59,   group: 12,  period: 6, .transitionMetal,     block: .d),
        
        ChemicalElement(81,  "Thallium",      "Tl",  204.383,  group: 13,  period: 6, .postTransitionMetal, block: .p),
        ChemicalElement(82,  "Lead",          "Pb",  207.2,    group: 14,  period: 6, .postTransitionMetal, block: .p),
        ChemicalElement(83,  "Bismuth",       "Bi",  208.9804, group: 15,  period: 6, .postTransitionMetal, block: .p),
        ChemicalElement(84,  "Polonium",      "Po",  208.9824, group: 16,  period: 6, .postTransitionMetal, block: .p),
        ChemicalElement(85,  "Astatine",      "At",  209.9871, group: 17,  period: 6, .metalloid,           block: .p),
        ChemicalElement(86,  "Randon",        "Rn",  222.0176, group: 18,  period: 6, .nobleGas,            block: .p),
        
        
        ChemicalElement(87,  "Francium",      "Fr",  223.0197, group: 1,   period: 7, .alkaliMetal,         block: .s),
        ChemicalElement(88,  "Radium",        "Ra",  226.0254, group: 2,   period: 7, .alkalineEarthMetal,  block: .s),
        
        ChemicalElement(89,  "Actinium",      "Ac",  227.0278, group: nil, period: 7, .actinide,            block: .f),
        ChemicalElement(90,  "Thorium",       "Th",  232.0380, group: nil, period: 7, .actinide,            block: .f),
        ChemicalElement(91,  "Protactinium",  "Pa",  231.035,  group: nil, period: 7, .actinide,            block: .f),
        ChemicalElement(92,  "Uranium",       "U",   238.0289, group: nil, period: 7, .actinide,            block: .f),
        ChemicalElement(93,  "Neptunium",     "Np",  237.0482, group: nil, period: 7, .actinide,            block: .f),
        ChemicalElement(94,  "Plutonium",     "Pu",  244.0642, group: nil, period: 7, .actinide,            block: .f),
        ChemicalElement(95,  "Americium",     "Am",  243.0614, group: nil, period: 7, .actinide,            block: .f),
        ChemicalElement(96,  "Curium",        "Cm",  247.0703, group: nil, period: 7, .actinide,            block: .f),
        ChemicalElement(97,  "Berkelium",     "Bk",  247.0703, group: nil, period: 7, .actinide,            block: .f),
        ChemicalElement(98,  "Californium",   "Cf",  251.0796, group: nil, period: 7, .actinide,            block: .f),
        ChemicalElement(99,  "Einsteinium",   "Es",  252.0829, group: nil, period: 7, .actinide,            block: .f),
        ChemicalElement(100, "Fermium",       "Fm",  257.0951, group: nil, period: 7, .actinide,            block: .f),
        ChemicalElement(101, "Mendelevium",   "Md",  258.095,  group: nil, period: 7, .actinide,            block: .f),
        ChemicalElement(102, "Nobelium",      "No",  259.1009, group: nil, period: 7, .actinide,            block: .f),
        ChemicalElement(103, "Lawrencium",    "Lr",  266.1193, group: nil, period: 7, .actinide,            block: .d),
        
        ChemicalElement(104, "Rutherfordium", "Rf",  261,      group: 4,   period: 7, .transitionMetal,     block: .d),
        ChemicalElement(105, "Dubnium",       "Db",  262,      group: 5,   period: 7, .transitionMetal,     block: .d),
        ChemicalElement(106, "Seaborgium",    "Sg",  262,      group: 6,   period: 7, .transitionMetal,     block: .d),
        ChemicalElement(107, "Bohrium",       "Bh",  267,      group: 7,   period: 7, .transitionMetal,     block: .d),
        ChemicalElement(108, "Hassium",       "Hs",  269,      group: 8,   period: 7, .transitionMetal,     block: .d),
        ChemicalElement(109, "Meitnerium",    "Mt",  268,      group: 9,   period: 7, .none,                block: .d),
        ChemicalElement(110, "Darmstadtium",  "Ds",  281.16,   group: 10,  period: 7, .none,                block: .d),
        ChemicalElement(111, "Roentgenium",   "Rg",  281.168,  group: 11,  period: 7, .none,                block: .d),
        ChemicalElement(112, "Copernicium",   "Cn",  285.174,  group: 12,  period: 7, .transitionMetal,     block: .d),
        
        ChemicalElement(113, "Nihonium",      "Nh",  286.1810, group: 13,  period: 7, .none,                block: .p),
        ChemicalElement(114, "Flerovium",     "Fl",  289,      group: 14,  period: 7, .postTransitionMetal, block: .p),
        ChemicalElement(115, "Moscovium",     "Mc",  289,      group: 15,  period: 7, .none,                block: .p),
        ChemicalElement(116, "Livermorium",   "Lv",  293,      group: 16,  period: 7, .none,                block: .p),
        ChemicalElement(117, "Tennessine",    "Ts",  294,      group: 17,  period: 7, .none,                block: .p),
        ChemicalElement(118, "Oganesson",     "Og",  294,      group: 18,  period: 7, .none,                block: .p),
    ]
    
    
    // MARK: - Type Methods
    
    
    // MARK: - Operators
    
    
    // MARK: - Type Alies
    
    
    //MARK: - Substructures
    
    public enum Classification {
        
        case actinide
        
        case alkaliMetal
        
        case alkalineEarthMetal
        
        case halogen
        
        case lanthanide
        
        case transitionMetal
        
        case postTransitionMetal
        
        case metalloid
        
        case nonmetal
        
        case reactiveNonmetal
        
        case nobleGas
        
        /// Special cases, such as hydrogen.
        case none
        
    }
    
    public enum Block {
        case s, p, d, f
    }
    
    
    //MARK: - Subscript
    
}
