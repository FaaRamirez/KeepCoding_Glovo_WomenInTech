""" KeepCoding Bootcamp: Mujeres en Tech (Glovo)"""
""" Practica de Katas de Programacion 29.10.2022"""
""" Alumna: Fatima Ramirez Simon """


"""
Provisional code. Its review and improvement is WIP.
This piece of code was delivered as a solution to the problem of creating a *process_matrix* function that recibes
a matrix (list of list) as a parameter and returns another matrix with the same size and number of elements.
Each element of the final matrix represents the mean of its old value and its neighbours (top, bottom, right, and left, if any).
"""


def null_columns(elements):
    """
    Recorre cada fila de la lista de listas.
    Añade un cero al inicio y al final de cada fila.
    """
    new_elements = elements
    for row in new_elements:
        row.insert(0, 0)
        row.append(0)
    return new_elements
    # [[0, 1, 2, 3, 0], [0, 2, 3, 1, 0]]


def null_list(elements):
    """
    Recorre cada fila de la lista de listas.
    Añade una lista de ceros al inicio y al final de la matriz.
    """
    new_elements = null_columns(elements)
    n = len(new_elements[0])
    accum = [0] * n
    new_elements.insert(0, accum)
    new_elements.append(accum)
    return new_elements
    # [[0, 0, 0, 0, 0], [0, 1, 2, 3, 0], [0, 2, 3, 1, 0], [0, 0, 0, 0, 0]]


def add_neighbours(elements):
    """
    Itera sobre cada lista de la matriz.
    Suma a cada numero de la lista su vecino de la derecha, izquierda, arriba y abajo.
    """
    accum = []

    for i, row in enumerate(elements):

        accum.append([])

        for j, value in enumerate(elements[i]):

            # Se mantiene la lista original de la primera y ultima posicion de la matriz
            if i == 0 or i == (len(elements)-1):
                new_value = (elements[i][j])
                accum[i].append(new_value)

            else:
                # A cada valor de la lista se le sumaran sus vecinos, excepto a j==0 y j==(len(i)-1)
                if j >= 1 and j < (len(elements[i])-1):
                    new_value = (elements[i][j]) + (elements[i][j-1]) + (elements[i][j+1]) + (elements[i-1][j]) + (elements[i+1][j])
                    accum[i].append(new_value)

                else:
                    # j==0 y j==(len(i)-1) mantienen su valor original
                    accum[i].append(elements[i][j])
        
    return accum 
    # [[0, 0, 0, 0, 0], [0, 3, 6, 6, 0], [0, 3, 7, 7, 0], [0, 0, 0, 0, 0]]


def remove_zeros(elements):
    """
    Elimina los ceros añadidos anteriormente
    correspondientes al inicio y final de cada columna
    y la fila del inicio y del final de la matriz
    """
    elements.pop(0)
    elements.pop((len(elements)-1))
    for i, rows in enumerate(elements):
        del rows[0]
        del rows[-1]
    return elements
    # [[3, 6, 6], [3, 7, 7]]


def get_average(elements):
    """
    Itera sobre cada lista de la matriz.
    Calcula el valor promedio en base a la posición del elemento.
    """
    avr = []

    for i, element in enumerate(elements):

        # En cada iteración, añade una lista vacía a la matriz
        avr.append([])

        for j, value in enumerate(elements[i]):
            
            # matriz de una sola lista
            if (i == 0) and (len(elements) == 1):

                # borde izquierdo y derecho
                if (j == 0) or (j == (len(elements[i])-1)):
                    new_value = round((elements[i][j]/2), 2)
                    avr[i].append(new_value)
                
                # centro
                else:
                    new_value = round((elements[i][j]/3), 2)
                    avr[i].append(new_value)

            # Row == 0 or Row == [-1]
            elif (i == 0) or (i == (len(elements)-1)):

                # esquina superior/inferior izquierda y derecha
                if (j == 0) or (j == (len(elements[i])-1)):
                    new_value = round((elements[i][j]/3),2)
                    avr[i].append(new_value)

                # borde superior/inferior
                else:
                    new_value = round((elements[i][j]/4), 2)
                    avr[i].append(new_value)
                    
            # Inner rows
            else:
                # borde izquierdo o derecho
                if (j == 0) or (j == (len(elements[i])-1)):
                    new_value = round((elements[i][j]/4), 2)
                    avr[i].append(new_value)
                    
            # Interior
                else:
                    new_value = round((elements[i][j]/5), 2)
                    avr[i].append(new_value)
    return avr
    # [[1.67, 2.25, 2.0], [2.0, 2.0, 2.33]]


def process_matrix(elements):
    """
    Procesa los elementos de la matriz original 
    en funcion de las formulas creadas anteriormente.
    """

    # Si algun elemento no es integer, se sustituira por un cero
    for i, row in enumerate(elements):
        for j, value in enumerate(elements[i]):
            if type(elements[i][j]) != int:
                elements[i][j] = 0

    zeros_matrix = null_list(elements)
    neighbours = add_neighbours(zeros_matrix)
    processed_matrix = remove_zeros(neighbours)
    final_matrix = get_average(processed_matrix)
            
    return final_matrix
    


# Tests:

# Len == 2
# m = [[1, 2, 3], [2, 3, 1]]
    # [[1.67, 2.25, 2.0], [2.0, 2.0, 2.33]]

# Len == 3
# m = [[1, 2, 3], [2, 3, 1], [3, 1, 2]]
    # [[1.67, 2.25, 2.0], [2.25, 1.8, 2.25], [2.0, 2.25, 1.33]]

# Len == 4
# m = [[1, 2, 3], [2, 3, 1], [3, 1, 2], [3, 1, 2]]
    # [[1.67, 2.25, 2.0], [2.25, 1.8, 2.25], [2.25, 2.0, 1.5], [2.33, 1.75, 1.67]]

# Len == 1
# m = [[1, 2, 3]]
    # [[1.5, 2.0, 2.5]]

# Lista con ceros
# m = [[1, 2, 3], [0, 0, 0]]
    # [[1.0, 1.5, 1.67], [0.33, 0.5, 1.0]]

# Omite ZeroDivisionError, ya que devuelve: float 0.0
# m = [[0, 0, 0], [0, 0, 0]] 
    # [[0.0, 0.0, 0.0], [0.0, 0.0, 0.0]]

# Listas de diferente tamaño
# m = [[2, 3, 1], [3, 1, 2], [3, 2]]
    # [[2.67, 1.75, 2.0], [2.25, 2.2, 1.0], [2.67, 2.0]]

# Listas con elementos diferentes a integer
# m = [['s', 1, 2], [1, 2, 3]] 
    # [[0.67, 1.25, 2.0], [1.0, 1.75, 2.33]]

# m = [[None, 1, 2], [1, 2, 3]]
    # [[0.67, 1.25, 2.0], [1.0, 1.75, 2.33]]


# print(process_matrix(m))