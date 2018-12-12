import Data.List
-- Punto a)

-- Para mayor expresividad
type Dia = Int
type Mes = Int
type Anio = Int

type Fecha = (Anio,Mes,Dia)

data Presidente = UnPresidente {
	apellido :: String,
	periodos :: [Periodo]
} deriving Show

data Periodo = UnPeriodo {
	inicio :: Fecha,
	fin :: Fecha, 
	acciones::[Accion]
} deriving Show

data Accion = UnaAccion {
	descripcion :: String,
	fecha :: Fecha,
	lugar :: String,
	beneficiados :: Int
} deriving Show

type Perspectiva = Accion -> Bool

data Periodista = UnPeriodista {
	nombre :: String,
	perspectiva :: Perspectiva
}

-- Ejemplos
presidentesDeEjemplo = [alfonsin, menem, puerta] 


alfonsin = UnPresidente {
	apellido = "Alfonsin",
	periodos = [alfonsin1]
}
menem = UnPresidente {
	apellido = "Menem",
	periodos = [menem1,menem2]
}
puerta = UnPresidente {
	apellido = "Puerta",
	periodos = [puerta1]
}

alfonsin1 = UnPeriodo {
	inicio = (1983,12,10),
	fin = (1989,7,7),
	acciones = [juicioJuntas, hiperInflacion]
}
menem1 = UnPeriodo {
	inicio = (1989,7,8),
	fin = (1995,12,9),
	acciones = [privatizacionYPF]
}	
menem2 = UnPeriodo {
	inicio = (1995,12,10),
	fin = (1999,12,9),
	acciones = []
}
puerta1 = UnPeriodo {
	inicio = (2001,12,21),
	fin = (2001,12,23),
	acciones = []
}

juicioJuntas = UnaAccion {
	descripcion = "Juicio a las juntas",
	fecha = (1985, 12, 9),
	lugar = "Buenos Aires",
	beneficiados = 30000000
}

hiperInflacion = UnaAccion {
	descripcion = "hiperInflacion",
	fecha = (1989, 1, 1),
	lugar = "Buenos Aires",
	beneficiados = 10
}

privatizacionYPF = UnaAccion {
	descripcion = "Privatizacion de YPF",
	fecha = (1992, 5, 3),
	lugar = "Campana",
	beneficiados = 1
}

ernesto = UnPeriodista {
	nombre = "Ernesto",
	perspectiva = conformista
}	

maria = UnPeriodista {
	nombre = "Maria",
	perspectiva = complice
}	
juan = UnPeriodista {
	nombre = "Juan",
	perspectiva = oriundo "Campana"
}	
-- a) Quiénes fueron presidente por más de un período (sin importar si fueron sucesivos o no)

presidentesMasDeUnPeriodo :: [Presidente] -> [Presidente]
presidentesMasDeUnPeriodo presidentes = filter ((>1).length.periodos) presidentes

-- b) En una fecha dada, quién era el presidente.

presidenteEnFecha:: [Presidente] -> Fecha -> Presidente
presidenteEnFecha presidentes fecha = (head.filter (esPresidenteEnFecha fecha)) presidentes

esPresidenteEnFecha:: Fecha -> Presidente -> Bool
esPresidenteEnFecha fecha presidente = any (enElPeriodo fecha) (periodos presidente)

enElPeriodo:: Fecha -> Periodo -> Bool
enElPeriodo fecha periodo = inicio periodo <= fecha && fecha <= fin periodo
-- Aprovechando el criterio de orden de las tuplas


-- 2) Acciones de gobierno

-- a) Si un determinado acto de gobierno fue bueno.

buenaAccion :: Accion -> Bool
buenaAccion accion = beneficiados accion > 10000

-- b) Si un presidente hizo algo bueno, es decir, si en alguno de sus periodos de gobierno hizo alguna accion de gobierno que se considere buena.

hizoAlgoBueno:: Presidente -> Bool
hizoAlgoBueno presidente = hizoAlgoQueEs buenaAccion presidente
-- Generalizacion con orden superior para el punto 3.
-- Para el punto 2 basta con 
-- hizoAlgoBueno presidente = any buenaAccion (accionesDel presidente )

hizoAlgoQueEs :: (Accion->Bool) -> Presidente -> Bool
hizoAlgoQueEs comoEsLaAccion presidente = any comoEsLaAccion (accionesDel presidente)

accionesDel:: Presidente -> [Accion]
accionesDel presidente  = concat (map acciones (periodos presidente)) 

-- 3) Calificacion Funcional de presidentes 
-- Aparecen los periodistas ( tambíen politólogos, columnistas y otros formadores de opinión pública) que califican a los presidentes según sus propias perspectivas políticas.
-- Se busca encontrar los nombres de todos los presidentes que sean del agrado de un determinado periodista .

--Conformista: Le agradan los presidentes que alguna vez hicieron algo bueno.

presidentesDelAgradoDe periodista presidentes = filter (esDelAgradoDe periodista) presidentes

esDelAgradoDe periodista presidente = hizoAlgoQueEs (perspectiva periodista) presidente

conformista :: Perspectiva
conformista = buenaAccion

-- Complice: Le agrada un presidente si hizo algo malo, alguna vez
complice:: Perspectiva
complice = not.buenaAccion

-- Oriundo de un lugar: Le agrada un presidente cuando hizo algo en el lugar indicado.
oriundo :: String -> Perspectiva
oriundo origen  = (origen==).lugar
