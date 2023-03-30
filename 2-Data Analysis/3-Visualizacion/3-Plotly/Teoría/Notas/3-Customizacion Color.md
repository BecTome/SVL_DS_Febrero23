Opciones:
- Argumentos como ``color``
- La funcion ``update_layout``:
	```Python
	fig.update_layout({'title':{'text': 'A New Title'}})
	```

## Argumento Color (Hue)
![[Color_argument.png]]

También podemos especificar nosotros los colores de cada categoria
![[Specific_colors.png]]
![[built_in_color_scales.png]]
![[pers_color_range.png]]

## Ejemplo: Color Students (Escala continua)
```Python
# Create your own continuous color scale
my_scale = ['rgb(255, 0, 0)', 'rgb(3, 252, 40)']

# Create the bar plot
fig = px.bar(data_frame=student_scores, 
             x='student_name', y='score', title='Student Scores by Student',
             # Set the color variable and scale
             color='score',
             color_continuous_scale=my_scale
             )
# Show the plot
fig.show()
```

## Ejemplo: Color Stocks (Escala discreta)
```Python
# Create the industry-color map
ind_color_map = {'Tech': "rgb(124, 250, 120)", "Oil": "rgb(112,128,144)", 
                 "Pharmaceuticals": "rgb(137, 109, 247)", 
                 "Professional Services": "rgb(255, 0, 0)"}
# Create the basic box plot
fig = px.box(
            # Set the data and y variable
            data_frame=revenues, y="Revenue",
            # Set the color map and variable
            color_discrete_map=ind_color_map,
            color='Industry')
# Show the plot
fig.show()
```


  

